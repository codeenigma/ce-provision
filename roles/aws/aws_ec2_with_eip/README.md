# AMI Debian Buster

Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_ec2_with_eip:
  aws_profile: "{{ _aws_profile }}"
  region: eu-west-3
  instance_type: t2.micro
  key_name: "{{ ce_provision.username }}@{{ ansible_hostname }}" # This needs to match your "provision" user SSH key.
  ami_name: "{{ _domain_name }}" # The name of an AMI image to use. Image must exists in the same region.
  ami_owner: self # Default to self-created image.
  vpc_subnet_id: subnet-xxx
  # An IAM Role name to associate with the instance.
  iam_role_name: "example"
  state: present
  instance_name: "{{ _domain_name }}"
  root_volume_size: 80
  ebs_optimized: true
  security_groups: []
  tags:
    Name: "{{ _domain_name }}"
  # Add an A record tied to the EIP.
  # Set the zone to empty to skip.
  route_53:
    zone: "example.com"
    record: "{{ _domain_name }}"
    aws_profile: another # Not necessarily the same as the "target" one.
    wildcard: true # Creates a matching wildcard CNAME

```

<!--ENDROLEVARS-->
