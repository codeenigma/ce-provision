# Python Pip Packages
Role to install a list of Python packages in a specified Python virtual environment.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
python_pip_packages:
  # These are usually set in the _init role using _venv_path, _venv_command and _venv_install_username but can be overridden.
  #venv_path: /path/to/venv
  #venv_command: /usr/bin/python3.11 -m venv
  #install_username: deploy # user to become when creating venv

  packages: []
  #  - name: pip
  #    state: latest

```

<!--ENDROLEVARS-->
