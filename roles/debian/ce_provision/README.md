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
  # File containing default roles and collections to install via Ansible Galaxy.
  # Roles will be installed to $HOME/.ansible/roles for the provision user. This roles path should be added to your ansible.cfg file.
  galaxy_custom_requirements_file: "/home/{{ _ce_provision.username }}/ce-provision/config/files/galaxy-requirements.yml"
  galaxy_roles_directory: "/home/{{ _ce_provision.username }}/.ansible/roles"
  upgrade_galaxy:
    enabled: true
    command: "/usr/local/bin/ansible-galaxy collection install --force"
    # cron variables - see https://docs.ansible.com/ansible/latest/collections/ansible/builtin/cron_module.html
    minute: 0
    hour: 1
    # day: 1
    # weekday: 7
    # month: 12
    # disabled: true

```

<!--ENDROLEVARS-->
