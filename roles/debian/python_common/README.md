# Python Common
Packages required by all Python scripts and applications.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
python_common:
  remove_packages:
    - python-pip
    - python3-yaml # linters need a newer version of PyYAML than the one that ships with Debian
    - python-botocore
    - python-urllib3
  install_packages:
    - python3-distutils
    - python3-venv
    - python3-pip
    - cloud-init # package can get removed with python3-yaml but we need it for auto-scale
```

<!--ENDROLEVARS-->
