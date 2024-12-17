#!/bin/sh
set -e

# Load OS information.
# shellcheck source=/dev/null
. /etc/os-release

usage(){
  /usr/bin/echo 'install.sh [OPTIONS]'
  /usr/bin/echo 'Install the latest ce-provision version, or the version specified as option.'
  /usr/bin/echo 'Please ensure you are using Debian Linux or similar and at least Bullseye (11) or higher.'
  /usr/bin/echo ''
  /usr/bin/echo 'Available options:'
  /usr/bin/echo '--version: ce-provision version to use (default: 2.x)'
  /usr/bin/echo '--user: Ansible controller user (default: controller)'
  /usr/bin/echo '--config: Git URL to your ce-provision Ansible config repository (default: https://github.com/codeenigma/ce-provision-config-example.git)'
  /usr/bin/echo '--config-branch: branch of your Ansible config repository to use (default: 1.x)'
  /usr/bin/echo '--no-firewall: skip installing iptables with ports 22, 80 and 443 open'
  /usr/bin/echo '--gitlab: install GitLab CE on this server (default: no, set to desired GitLab address to install, e.g. gitlab.example.com)'
  /usr/bin/echo '--letsencrypt: try to create an SSL certificate with LetsEncrypt (requires DNS pointing at this server for provided GitLab URL)'
  /usr/bin/echo '--aws: enable AWS support'
  /usr/bin/echo '--docker: script is running in a Docker container'
  /usr/bin/echo ''
}

# Parse options arguments.
parse_options(){
  while [ "${1:-}" ]; do
    case "$1" in
      "--version")
          shift
          VERSION="$1"
        ;;
      "--user")
          shift
          CONTROLLER_USER="$1"
        ;;
      "--config")
          shift
          CONFIG_REPO="$1"
        ;;
      "--config-branch")
          shift
          CONFIG_REPO_BRANCH="$1"
        ;;
      "--gitlab")
          shift
          GITLAB_URL="$1"
        ;;
      "--letsencrypt")
          LE_SUPPORT="yes"
        ;;
      "--no-firewall")
          FIREWALL="false"
        ;;
      "--aws")
          AWS_SUPPORT="true"
        ;;
      "--docker")
          IS_LOCAL="true"
        ;;
        *)
        usage
        exit 1
        ;;
    esac
    shift
  done
}

# Set default variables.
VERSION="2.x"
CONTROLLER_USER="controller"
CONFIG_REPO="https://github.com/codeenigma/ce-provision-config-example.git"
CONFIG_REPO_BRANCH="1.x"
GITLAB_URL="no"
LE_SUPPORT="no"
FIREWALL="true"
AWS_SUPPORT="false"
IS_LOCAL="false"
SERVER_HOSTNAME=$(hostname)

# Parse options.
parse_options "$@"

# Set the hostname for Git email to our GitLab URL, if set.
if [ "$GITLAB_URL" != "no" ]; then
  SERVER_HOSTNAME=$GITLAB_URL
fi

# Check root user.
if [ "$(id -u)" -ne 0 ]
  then echo "Please run this script as root or using sudo!"
  exit
fi

# Check we are using a compatible Linux distribution.
/usr/bin/echo "-------------------------------------------------"
if [ "$ID" != "debian" ]; then
  if [ "$ID_LIKE" != "debian" ]; then
    /usr/bin/echo "ce-provision only supports Debian Linux and derivatives."
    exit 0
  else
    /usr/bin/echo "ce-provision works best with Debian Linux, it may work with this distro but no promises!"
    /usr/bin/echo "-------------------------------------------------"
    /usr/bin/echo "Carrying on regardless..."
    /usr/bin/echo "-------------------------------------------------"
  fi
fi

/usr/bin/echo "Beginning ce-provision installation."
/usr/bin/echo "-------------------------------------------------"

# Create required user.
/usr/bin/echo "Check if user named $CONTROLLER_USER exists."
# Check if user exists
if /usr/bin/id "$CONTROLLER_USER" >/dev/null 2>&1; then
  /usr/bin/echo "The user named $CONTROLLER_USER already exists. Skipping."
else
  # User not found so let's create them.
  /usr/bin/echo "Create user named $CONTROLLER_USER."
  /usr/sbin/useradd -s /bin/bash "$CONTROLLER_USER"
  /usr/bin/echo "$CONTROLLER_USER":"$CONTROLLER_USER" | chpasswd -m
  /usr/bin/install -m 755 -o "$CONTROLLER_USER" -g "$CONTROLLER_USER" -d /home/"$CONTROLLER_USER"
  /usr/bin/install -m 700 -o "$CONTROLLER_USER" -g "$CONTROLLER_USER" -d /home/"$CONTROLLER_USER"/.ssh
  /usr/bin/echo root:"$CONTROLLER_USER" | chpasswd -m
  /usr/bin/echo "$CONTROLLER_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"$CONTROLLER_USER"
  /usr/bin/chmod 0440 /etc/sudoers.d/"$CONTROLLER_USER"
fi
/usr/bin/echo "-------------------------------------------------"

# Install APT packages.
/usr/bin/echo "Install required packages."
/usr/bin/echo "-------------------------------------------------"
/usr/bin/apt-get update
/usr/bin/apt-get dist-upgrade -y -o Dpkg::Options::="--force-confnew"
/usr/bin/apt-get install -y -o Dpkg::Options::="--force-confnew" \
  git ca-certificates git-lfs \
  openssh-client nfs-common stunnel4 \
  python3-venv python3-debian \
  zip unzip gzip tar dnsutils
/usr/bin/echo "-------------------------------------------------"

# Install Ansible in a Python virtual environment.
/usr/bin/echo "Install Ansible and dependencies."
/usr/bin/echo "-------------------------------------------------"
/usr/bin/su - "$CONTROLLER_USER" -c "/usr/bin/python3 -m venv /home/$CONTROLLER_USER/ce-python"
/usr/bin/su - "$CONTROLLER_USER" -c "/home/$CONTROLLER_USER/ce-python/bin/python3 -m pip install --upgrade pip"
/usr/bin/su - "$CONTROLLER_USER" -c "/home/$CONTROLLER_USER/ce-python/bin/pip install ansible netaddr python-debian"
/usr/bin/su - "$CONTROLLER_USER" -c "/home/$CONTROLLER_USER/ce-python/bin/ansible-galaxy collection install ansible.posix -p /home/$CONTROLLER_USER/.ansible/collections/ansible_collections --force"
if [ "$AWS_SUPPORT" = "true" ]; then
  /usr/bin/su - "$CONTROLLER_USER" -c "/home/$CONTROLLER_USER/ce-python/bin/pip install boto3"
fi
/usr/bin/echo "-------------------------------------------------"

# Install ce-provision.
/usr/bin/echo "Install ce-provision."
/usr/bin/echo "-------------------------------------------------"
if [ ! -d "/home/$CONTROLLER_USER/ce-provision" ]; then
  /usr/bin/su - "$CONTROLLER_USER" -c "git clone --branch $VERSION https://github.com/codeenigma/ce-provision.git /home/$CONTROLLER_USER/ce-provision"
else
  /usr/bin/echo "ce-provision directory at /home/$CONTROLLER_USER/ce-provision already exists. Skipping."
  /usr/bin/echo "-------------------------------------------------"
fi
/usr/bin/mkdir -p "/home/$CONTROLLER_USER/ce-provision/galaxy/roles"
# Create playbook for ce-provision.
/bin/cat >"/home/$CONTROLLER_USER/ce-provision/provision.yml" << EOL
---
- hosts: "localhost"
  become: true
  vars_files:
    - vars.yml
  tasks:
    - name: Install ce-provision.
      ansible.builtin.import_role:
        name: debian/ce_provision
    - name: Configure controller user.
      ansible.builtin.import_role:
        name: debian/user_provision
EOL
# Create vars file.
/bin/cat >"/home/$CONTROLLER_USER/ce-provision/vars.yml" << EOL
---
_domain_name: ${SERVER_HOSTNAME}
_ce_provision_data_dir: /home/${CONTROLLER_USER}/ce-provision/data
_ce_provision_username: ${CONTROLLER_USER}
ce_provision:
  venv_path: /home/${CONTROLLER_USER}/ce-python
  venv_command: /usr/bin/python3 -m venv
  venv_install_username: ${CONTROLLER_USER}
  upgrade_timer_name: upgrade_ce_provision_ansible
  aws_support: ${AWS_SUPPORT}
  new_user: ${CONTROLLER_USER}
  username: ${CONTROLLER_USER}
  ssh_key_bits: "521"
  ssh_key_type: ecdsa
  public_key_name: id_ecdsa.pub
  own_repository: "https://github.com/codeenigma/ce-provision.git"
  own_repository_branch: "${VERSION}"
  own_repository_skip_checkout: false
  local_dir: "/home/${CONTROLLER_USER}/ce-provision"
  config_repository: "${CONFIG_REPO}"
  config_repository_branch: "${CONFIG_REPO_BRANCH}"
  config_repository_skip_checkout: false
  groups: []
  contrib_roles:
    - directory: wazuh
      repo: https://github.com/wazuh/wazuh-ansible.git
      branch: "v4.7.2"
    - directory: systemd_timers
      repo: https://github.com/vlcty/ansible-systemd-timers.git
      branch: master
  galaxy_custom_requirements_file: ""
  upgrade_galaxy:
    enabled: true
    command: "/home/${CONTROLLER_USER}/ce-python/bin/ansible-galaxy collection install --force"
    on_calendar: "Mon *-*-* 04:00:00"
user_provision:
  username: "${CONTROLLER_USER}"
  home: "/home/${CONTROLLER_USER}"
  create: false
  create_home: false
  update_password: always
  utility_username: "${CONTROLLER_USER}"
  utility_host: localhost
  sudoer: true
  groups:
    - bypass2fa
  ssh_keys:
    - "{{ lookup('file', '/home/${CONTROLLER_USER}/ce-provision/data/localhost/home/${CONTROLLER_USER}/.ssh/id_ecdsa.pub') }}"
  ssh_private_keys: []
  known_hosts: []
  known_hosts_hash: true
firewall_config:
  purge: true
  firewall_state: started
  firewall_enabled_at_boot: true
  firewall_enable_ipv6: false
  firewall_log_dropped_packets: true
  firewall_disable_ufw: true
  firewall_allowed_tcp_ports: []
  rulesets:
    - ssh_open
    - web_open
  ssh_open:
    firewall_allowed_tcp_ports:
      - "22"
  web_open:
    firewall_allowed_tcp_ports:
      - "80"
      - "443"
EOL

# Tell Ansible this is a Docker container
if [ "$IS_LOCAL" = "true" ]; then
  /usr/bin/su - "$CONTROLLER_USER" -c "/home/$CONTROLLER_USER/ce-python/bin/ansible-playbook --extra-vars \"{is_local: $IS_LOCAL}\" /home/$CONTROLLER_USER/ce-provision/provision.yml"
  # Run a second time to install Ansible Galaxy roles in the right place
  /usr/bin/su - "$CONTROLLER_USER" -c "cd /home/$CONTROLLER_USER/ce-provision && /home/$CONTROLLER_USER/ce-python/bin/ansible-playbook --extra-vars \"{is_local: $IS_LOCAL}\" /home/$CONTROLLER_USER/ce-provision/provision.yml"
else
  /usr/bin/su - "$CONTROLLER_USER" -c "/home/$CONTROLLER_USER/ce-python/bin/ansible-playbook /home/$CONTROLLER_USER/ce-provision/provision.yml"
  # Run a second time to install Ansible Galaxy roles in the right place
  /usr/bin/su - "$CONTROLLER_USER" -c "cd /home/$CONTROLLER_USER/ce-provision && /home/$CONTROLLER_USER/ce-python/bin/ansible-playbook /home/$CONTROLLER_USER/ce-provision/provision.yml"
fi
/usr/bin/rm "/home/$CONTROLLER_USER/ce-provision/provision.yml"

# Install firewall
if [ "$FIREWALL" = "true" ]; then
# Create playbook for firewall.
  /usr/bin/echo "-------------------------------------------------"
  /usr/bin/echo "Install firewall."
  /usr/bin/echo "-------------------------------------------------"
  /bin/cat >"/home/$CONTROLLER_USER/ce-provision/provision.yml" << EOL
---
- hosts: "localhost"
  become: true
  vars_files:
    - vars.yml
  tasks:
    - name: Install iptables firewall.
      ansible.builtin.import_role:
        name: debian/firewall_config
EOL
  /usr/bin/su - "$CONTROLLER_USER" -c "cd /home/$CONTROLLER_USER/ce-provision && /home/$CONTROLLER_USER/ce-python/bin/ansible-playbook /home/$CONTROLLER_USER/ce-provision/provision.yml"
  /usr/bin/echo "-------------------------------------------------"
else
  /usr/bin/echo "-------------------------------------------------"
  /usr/bin/echo "Skipping firewall."
  /usr/bin/echo "-------------------------------------------------"
fi

# Install GitLab
if [ "$GITLAB_URL" != "no" ]; then
  /usr/bin/echo "Install GitLab."
  /usr/bin/echo "-------------------------------------------------"
  # Create playbook.
  /bin/cat >"/home/$CONTROLLER_USER/ce-provision/provision.yml" << EOL
---
- hosts: "localhost"
  become: true
  vars_files:
    - vars.yml
  tasks:
    - name: Install GitLab Runner.
      ansible.builtin.import_role:
        name: debian/gitlab_runner
    - name: Install GitLab.
      ansible.builtin.import_role:
        name: debian/gitlab
EOL
  # Create vars file.
  /bin/cat >"/home/$CONTROLLER_USER/ce-provision/vars.yml" << EOL
---
_domain_name: ${SERVER_HOSTNAME}
gitlab_runner:
  apt_origin: "origin=packages.gitlab.com/runner/gitlab-runner,codename=\${distro_codename},label=gitlab-runner" # used by apt_unattended_upgrades
  apt_signed_by: https://packages.gitlab.com/runner/gitlab-runner/gpgkey
  concurrent_jobs: 10
  check_interval: 0
  session_timeout: 1800
  runners: []
  install_fargate: false
  restart: false
  username: "${CONTROLLER_USER}"
  docker_group: "docker"
  runner_workingdir: "/home/${CONTROLLER_USER}/build"
  runner_config: "/etc/gitlab-runner/config.toml"
gitlab:
  apt_origin: "origin=packages.gitlab.com/gitlab/gitlab-ce,codename=\${distro_codename},label=gitlab-ce" # used by apt_unattended_upgrades
  apt_signed_by: https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
  server_name: "${GITLAB_URL}"
  email: "gitlab@${GITLAB_URL}"
  gitlab_route_53:
    zone: ""
  linux_user: git
  linux_group: git
  linux_uid: nil
  linux_gid: nil
  linux_shell: /bin/sh
  linux_user_home: /var/opt/gitlab
  username: GitLab
  email: "gitlab@${GITLAB_URL}"
  default_theme: 1
  disable_signup: true
  disable_signin: false
  private_projects: true
  unicorn_worker_processes: 2
  puma_worker_processes: 2
  initial_root_password: "Ch@ng3m3"
  ldap:
    enable: false
  mattermost: false
  omniauth: false
  prometheus: "true"
  node_exporter: "true"
  alertmanager: "true"
  nginx:
    enable: true
    listen_port: 443
    listen_https: 443
    client_max_body_size: "250m"
    redirect_http_to_https: "true"
    redirect_http_to_https_port: 80
    custom_nginx_config: ""
EOL
  if [ "$LE_SUPPORT" = "yes" ]; then
    /usr/bin/echo "Will try to create an SSL certificate with LetsEncrypt."
    /usr/bin/echo "*** THIS STEP WILL FAIL IF YOUR DNS IS NOT CORRECT! ***"
    if [ -n "$(dig +short "$GITLAB_URL".)" ]; then
      /usr/bin/echo "DNS record found, attempting LetsEncrypt request..."
      # Write GitLab vars with LE for SSL
      /bin/cat <<EOT >> "/home/$CONTROLLER_USER/ce-provision/vars.yml"
  letsencrypt: "true"
  ssl:
    enabled: false
EOT
      /usr/bin/echo "-------------------------------------------------"
    else
      /usr/bin/echo "No DNS found for provided URL, will create a self-signed certificate instead."
      # Write GitLab vars with self-signed SSL
      /bin/cat <<EOT >> "/home/$CONTROLLER_USER/ce-provision/vars.yml"
  letsencrypt: "false"
  ssl:
    enabled: true
    handling: selfsigned
    replace_existing: false
EOT
      /usr/bin/echo "-------------------------------------------------"
    fi
  else
    # Write GitLab vars with self-signed SSL
    /usr/bin/echo "Create a self-signed SSL certificate."
    /bin/cat <<EOT >> "/home/$CONTROLLER_USER/ce-provision/vars.yml"
  letsencrypt: "false"
  ssl:
    enabled: true
    handling: selfsigned
    replace_existing: false
EOT
    /usr/bin/echo "-------------------------------------------------"
  fi
  /usr/bin/su - "$CONTROLLER_USER" -c "cd /home/$CONTROLLER_USER/ce-provision && /home/$CONTROLLER_USER/ce-python/bin/ansible-playbook /home/$CONTROLLER_USER/ce-provision/provision.yml"
  /usr/bin/echo "-------------------------------------------------"
else
  /usr/bin/echo "GitLab not requested. Skipping."
  /usr/bin/echo "-------------------------------------------------"
fi
# Tidy up if not a container
if [ "$IS_LOCAL" = "false" ]; then
  /usr/bin/rm "/home/$CONTROLLER_USER/ce-provision/vars.yml"
  /usr/bin/rm "/home/$CONTROLLER_USER/ce-provision/provision.yml"
fi
/usr/bin/echo "DONE."
