# AWS ElastiCache

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_elasticache:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  name: example
  description: example
  state: present
  subnets:
    - subnet-aaaaaaaa
    - subnet-bbbbbbbb
  elasticache_engine: memcached
  #cache_engine_version: 1.4.14
  #cache_parameter_group: my_custom_parameters
  elasticache_node_type: cache.t3.medium
  elasticache_nodes: 1
  elasticache_port: 11211
  elasticache_security_groups: [] # list of security group names, converted to IDs by aws_security_groups role
  #zone: eu-west-1a # AZ where the cluster will reside
```

<!--ENDROLEVARS-->
