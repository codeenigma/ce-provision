# Ansible
Install Ansible in a Python virtual environment.

Note, it is vitally important that Ansible is *not* installed via `apt` or `pip` globally, or you will likely not get the correct version of Ansible when you try to run shell scripts. The role will try and take care of this for you, but for extra safety you could manually check prior to running `ce-provision`.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
ce_ansible:
  # These are usually set within another role using _venv_path, _venv_command and _ansible_install_username but can be overridden.
  #venv_path: "/home/{{ ce_provision.username }}/ansible"
  #venv_command: /usr/bin/python3.11 -m venv
  #ansible_install_username: deploy # user to become when creating venv
  upgrade:
    enabled: true # create systemd timer to auto-upgrade Ansible
    command: "{{ _venv_path }}/bin/python3 -m pip install --upgrade ansible" # if you set venv_path above then set it here too
    on_calendar: "*-*-* 01:30:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events
  linters:
    enabled: true # will not install linters if false, installing linters breaks cloud-init

```

<!--ENDROLEVARS-->
