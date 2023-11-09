# Python Boto
Role to install the `boto3` library for Python integration with AWS services.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
python_boto:
  boto3_version: "" # version string, e.g. "1.22.13" - empty string means latest
  # These are usually set within another role using _venv_path and _venv_command but can be overridden.
  #venv_path: /path/to/venv
  #venv_command: /usr/bin/python3.11 -m venv
```

<!--ENDROLEVARS-->
