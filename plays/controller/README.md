# Base playbook for setting up an infra controller.
This playbook provides a model for managing an Ansible infra controller with ce-provision based at AWS.

If your server is not in AWS or you are not using the AWS EC2 inventory plugin, you must ensure your server's hostname is in your Ansible hosts file (`config/hosts/hosts` or `hosts.yml`) and provide the same hostname in the `_provision_host` variable. Then call `provision.yml` directly, for example:

```yaml
---
- name: Configure my controller server.
  ansible.builtin.import_playbook: "{{ _ce_provision_base_dir }}/plays/controller/provision.yml"
  vars:
    _env_type: util
    _provision_host: controller.acme.com
    _profile: controller
```

If you are using the AWS EC2 inventory plugin and the Code Enigme recommended set-up, you must provide the `_aws_resource_name` variable - note, this is hyphenated, no dots - and call `aws_controller.yml`, for example:

```yaml
---
- name: Configure my controller server at AWS.
  ansible.builtin.import_playbook: "{{ _ce_provision_base_dir }}/plays/controller/aws_controller.yml"
  vars:
    _env_type: util
    _aws_region: eu-west-1
    _aws_resource_name: controller-acme-com
    _profile: controller
```

This will create or find an EC2 instance with the AWS tag of `Name: controller-acme-com` which will be in an inventory group called `_controller_acme_com`.

@TODO provide example infra repo for use with the AWS EC2 inventory plugin.
