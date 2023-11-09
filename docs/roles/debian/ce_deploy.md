# ce-deploy
Installs Code Enigma's deploy stack on a server.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_ce_deploy:
  username: "{% if is_local is defined and is_local %}ce-dev{% else %}deploy{% endif %}"

ce_deploy:
  new_user: true # set to false if user already exists or is ephemeral, e.g. an LDAP user
  key_name: id_rsa.pub # existing users may have a key of a different name
  username: "{{ _ce_deploy.username }}"
  own_repository: "https://github.com/codeenigma/ce-deploy.git"
  own_repository_branch: "master"
  config_repository: ""
  config_repository_branch: "master"
  local_dir: "/home/{{ _ce_deploy.username }}/ce-deploy"
  ce_provision_dir: "/home/controller/ce-provision"
  # List of additional groups to add the user to.
  groups: []
  # File containing default roles and collections to install via Ansible Galaxy.
  # Roles will be installed to $HOME/.ansible/roles for the provision user. This roles path should be added to your ansible.cfg file.
  galaxy_custom_requirements_file: "/home/{{ _ce_deploy.username }}/ce-deploy/config/files/galaxy-requirements.yml"
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
