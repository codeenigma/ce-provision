# Python Common
Packages required by all Python scripts and applications.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
python_common:
  cleanup: false # set to true to remove unwanted packages
  remove_packages: [] # list of packages to remove if cleanup: true
    # Example from ansible role
    #- python-pip
    #- python3-yaml # linters need a newer version of PyYAML than the one that ships with Debian
    #- python-botocore
    #- python-urllib3
  # Commonly required Python system packages
  install_packages:
    - python3-distutils
    - python3-debian
    - python3-venv
    - cloud-init # package can get removed with python3-yaml but we need it for auto-scale

```

<!--ENDROLEVARS-->
