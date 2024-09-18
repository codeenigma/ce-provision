# Ansible Galaxy
Installs Ansible collections and roles with Ansible Galaxy.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
ansible_galaxy:
  # Usually set in the _init role using _venv_path but can be overridden.
  #venv_path: "/home/controller/ce-python"

  username: controller
  extra_params: --force # extra params to pass to ansible-galaxy, e.g. -p /path/to/install
  # File containing default roles and/or collections to install via Ansible Galaxy.
  # Roles will be installed to $HOME/.ansible/roles for the provision user. This roles_path should be added to your ansible.cfg file.
  galaxy_requirements_file: "/home/{{ _ce_provision_username }}/ce-provision/config/files/galaxy-requirements.yml"
  upgrade_galaxy:
    enabled: true
    name: example # should be unique per job, per server
    on_calendar: "Mon *-*-* 04:00:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->
