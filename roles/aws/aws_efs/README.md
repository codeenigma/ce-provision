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
  # SG names - ID lookup is automatic. Note, the assumption is that all subnets have the same SGs.
  security_groups: []
  # Whether to encrypt the volume or not.
  encrypt: false
  backup: "{{ _infra_name }}-{{ _env_type }}" # Name of the AWS Backup plan to use to backup the instance.

```

<!--ENDROLEVARS-->
