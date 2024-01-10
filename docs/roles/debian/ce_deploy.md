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
  # Location of Ansible installation and components.
  venv_path: "/home/{{ _ce_deploy.username }}/ansible"
  venv_command: /usr/bin/python3 -m venv
  install_username: "{{ _ce_deploy.username }}"
  # Other ce-deploy settings.
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
    command: "/home/{{ _ce_deploy.username }}/ansible/bin/ansible-galaxy collection install --force" # must match venv_path
    on_calendar: "Mon *-*-* 01:00:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->