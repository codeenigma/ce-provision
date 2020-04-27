# AMI Debian Buster
Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---

aws_ec2_with_eip:
  aws_profile: default
  region: eu-west-3
  instance_type: t2.micro
  key_name: "{{ ansible_provision.username }}@{{ ansible_hostname }}" # This needs to match your "provision" user SSH key.
  ami_name: "{{ domain_name }}" # The name of an AMI image to use. Image must exists in the same region.
  ami_owner: self # Default to self-created image.
  vpc_subnet_id: subnet-xxx
  state: running
  instance_name: "{{ domain_name }}"
  root_volume_size: 80
  security_groups: []
  tags:
    Name: "{{ domain_name }}"
```

<!--ENDROLEVARS-->
