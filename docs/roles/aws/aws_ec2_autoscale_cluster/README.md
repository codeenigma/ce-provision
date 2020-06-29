# Autoscale cluster

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
# This is used to construct:
# - the base cidr_block as {{ cidr_base }}.0/16
# - subnets cidr_block as
#   a {{ cidr_base }}.0/26
#   b {{ cidr_base }}.64/26
#   c {{ cidr_base }}.128/26
_aws_ec2_autoscale_cluster_cidr_base: "10.0.0"
aws_ec2_autoscale_cluster:
aws_profile: default
region: eu-west-3
name: "example"
cidr_block: "{{ _aws_ec2_autoscale_cluster_cidr_base }}.0/24"
subnets:
# - az: a
#   cidr: "{{ _aws_ec2_autoscale_cluster_cidr_base }}.0/26"
- az: b
cidr: "{{ _aws_ec2_autoscale_cluster_cidr_base }}.64/26"
- az: c
cidr: "{{ _aws_ec2_autoscale_cluster_cidr_base }}.128/26"
instance_type: t2.micro
key_name: "{{ ansible_provision.username }}@{{ ansible_hostname }}" # This needs to match your "provision" user SSH key.
ami_name: "example" # The name of an AMI image to use. Image must exists in the same region.
ami_owner: self # Default to self-created image.
root_volume_size: 40
ami_playbook_file: "{{ playbook_dir }}/ami.yml"
min_size: 4
max_size: 8
security_groups: []
tags:
Name: "example"
# Hosts to peer with. This will gather vpc info from the Name tag and create a peering connection and route tables.
peering:
- name: utility-server.example.com
region: eu-west-3
# Associated RDS instance.
rds:
rds: no # wether to create an instance.
db_instance_class: db.m5.large
engine: mariadb
#engine_version: 5.7.9
```

<!--ENDROLEVARS-->
