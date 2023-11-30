# AWS EFS

Creates or update an EFS volume.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_efs:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  name: example
  # If false, we omit tags enterly and leave them as is.
  purge_tags: false
  tags: {}
  state: present
  wait: true
  # Subnets names.
  subnets: []
  security_groups: [] # list of security group names, converted to IDs by aws_security_groups role
  # Whether to encrypt the volume or not.
  encrypt: false
  backup: "{{ _infra_name }}-{{ _env_type }}" # Name of the AWS Backup plan to use to backup the instance.

```

<!--ENDROLEVARS-->
