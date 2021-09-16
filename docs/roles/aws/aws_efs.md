# AWS EFS

Creates or update an EFS volume.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_efs:
  aws_profile: "{{ _aws_profile }}"
  region: eu-west-3
  name: example
  # If false, we omit tags enterly and leave them as is.
  purge_tags: false
  tags: {}
  state: present
  wait: true
  # Subnets names.
  subnets: []
  # SG names. Note, the assumption is that all subnets have the same SGs.
  security_groups: []
  # Whether to encrypt the volume or not.
  encrypt: false

```

<!--ENDROLEVARS-->
