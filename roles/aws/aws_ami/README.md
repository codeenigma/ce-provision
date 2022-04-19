# AWS AMI
Creates an image from a selected base with Packer, provisioned with an Ansible Playbook.

## Dependencies
This requires boto and Packer on the "provisioning" server.

If using the 'repack' operation, so your new AMI gets created from a temporary EC2 instance instead built by Packer, your playbook `hosts` line will need to look like this:

```yaml
- hosts: "{{ _aws_ami_host | default('default') }}"
  become: true
```

Like that it will use `_aws_ami_host` if available and default to `default` if not, which is the value expected by Packer for the 'create' operation.

<!--TOC-->
<!--ENDTOC-->
<!--ROLEVARS-->
## Default variables
```yaml
---
aws_ami:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  instance_type: t2.micro
  virtualization_type: hvm
  root_device_type: ebs
  name_filter: "debian-10-amd64-*"
  ami_name: "example"
  owner: "136693071363" # Global AWS account ID of owner, defaults to Debian official
  encrypt_boot: false
  playbook_file: "{{ playbook_dir }}/base-playbook.yml" # Path to a playbook used to provision the image.
  # Operation can be one of:
  # - create: delete existing image if any and re-create a new one.
  # - ensure: Only create an image if it doesn't already exists.
  # - delete: Delete image and snapshots.
  #@todo find better names.
  operation: ensure
  # Ansible groups to add the target to. Useful for picking up group_vars.
  groups: []
  # groups:
  #   - "all"
  #   - "example"
  # A string of additional arguments to pass as ansible --extra-vars.
  # It must me escaped already, and will be passed as-is.
  extra_vars: ""

```

<!--ENDROLEVARS-->
