# Base playbooks for creating a new AWS ASG.
For a standard ASG build just add `cluster.yml` to your environment play, like this:

```yaml
- import_playbook: "{{ _ce_provision_base_dir }}/plays/aws_asg/cluster.yml"
  vars:
    _aws_region: eu-west-1
    _env_type: dev
    _aws_resource_name: cluster-acme-com
```

If you have specific requirements for your AMIs you can copy these plays to your infra repository and alter them accordingly. Don't forget to copy/include `launch.yml` from the `_ec2_standalone` plays or orchestration of brand new clusters will fail.

@TODO provide example infra repo for use with the AWS EC2 inventory plugin.
