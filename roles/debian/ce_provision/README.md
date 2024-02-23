# ce-provision
Installs Code Enigma's infrastructure management stack on a server.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
# See roles/_init/defaults/main.yml for extra variables repo settings.
_ce_provision:
  username: "{% if is_local is defined and is_local %}ce-dev{% else %}controller{% endif %}"

ce_provision:
  # Location of Ansible installation and components.
  venv_path: "/home/{{ _ce_provision.username }}/ansible"
  venv_command: /usr/bin/python3 -m venv
  install_username: "{{ _ce_provision.username }}"
  upgrade_timer_name: upgrade_ce_provision_ansible
  # Other ce-provision settings.
  username: "{{ _ce_provision.username }}"
  new_user: true # set to false if user already exists or is ephemeral, e.g. an LDAP user
  key_name: id_rsa.pub # existing users may have a key of a different name
  # Main repo.
  own_repository: "https://github.com/codeenigma/ce-provision.git"
  own_repository_branch: "master"
  own_repository_skip_checkout: false
  # Destination.
  local_dir: "/home/{{ _ce_provision.username }}/ce-provision"
  # Private config repo.
  config_repository: ""
  config_repository_branch: "master"
  config_repository_skip_checkout: false
  # List of additional groups to add the user to.
  groups: []
  # Roles downloaded from git repositories that are not available via Ansible Galaxy.
  contrib_roles:
    - directory: wazuh
      repo: https://github.com/wazuh/wazuh-ansible.git
      branch: "v4.7.2"
    - directory: systemd_timers
      repo: https://github.com/vlcty/ansible-systemd-timers.git
      branch: master
  # File containing default roles and collections to install via Ansible Galaxy.
  # Roles will be installed to $HOME/.ansible/roles for the provision user. This roles path should be added to your ansible.cfg file.
  galaxy_custom_requirements_file: "/home/{{ _ce_provision.username }}/ce-provision/config/files/galaxy-requirements.yml"
  upgrade_galaxy:
    enabled: true
    command: "/home/{{ _ce_provision.username }}/ansible/bin/ansible-galaxy collection install --force" # must match venv_path
    on_calendar: "Mon *-*-* 04:00:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->
