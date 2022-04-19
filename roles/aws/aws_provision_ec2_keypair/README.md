# AWS key pair.
Creates a key pair for the current "provision user"
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_provision_ec2_keypair:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  key_name: "{{ ce_provision.username }}@{{ ansible_hostname }}"

```

<!--ENDROLEVARS-->
