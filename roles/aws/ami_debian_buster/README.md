# AMI Debian Buster
Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.

## Dependencies
This requires Boto3 and Packer on the "provisioning" server.

<!--TOC-->
<!--ENDTOC-->
<!--ROLEVARS-->
## Default variables
```yaml
---

ami_debian_buster:
  aws_profile: default
  region: us-east-2
  instance_type: t2.micro
  ami_name: "{{ domain_name }}"
  playbook_file: "{{ playbook_dir }}/base-playbook.yml" # Path to a playbook used to provision the image.
  # Operation can be one of:
  # - create: delete existing image if any and re-create a new one.
  # - ensure: Only create an image if it doesn't already exists.
  # - delete: Delete image and snapshots.
  #@todo find better names.
  operation: ensure
```

<!--ENDROLEVARS-->
