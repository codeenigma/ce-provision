# ce-provision
Installs Code Enigma's infrastructure management stack on a server. Note, the `_init` role creates the user and installs Ansible in a virtual environment, so that must be run prior to the `ce_provision` role.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
# See roles/_init/defaults/main.yml for Ansible installation, controller user creation and extra variables repo settings.
ce_provision:
  # Other ce-provision settings.
  username: "{{ _ce_provision_username }}"
  # Main repo.
  own_repository: "https://github.com/codeenigma/ce-provision.git"
  own_repository_branch: "master"
  own_repository_skip_checkout: false
  # Destination.
  local_dir: "/home/{{ _ce_provision_username }}/ce-provision"
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
  galaxy_custom_requirements_file: "/home/{{ _ce_provision_username }}/ce-provision/config/files/galaxy-requirements.yml"
  upgrade_galaxy:
    enabled: true
    command: "/home/{{ _ce_provision_username }}/ansible/bin/ansible-galaxy collection install --force" # must match venv_path
    on_calendar: "Mon *-*-* 04:00:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->
