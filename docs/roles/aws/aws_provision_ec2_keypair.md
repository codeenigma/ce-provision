# AWS key pair.
Creates a key pair for the current "provision user"
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_provision_ec2_keypair:
  aws_profile: default
  region: eu-west-3
  key_name: "{{ ce_provision.username }}@{{ ansible_hostname }}"

```

<!--ENDROLEVARS-->
