# VPC
Creates a VPC and associated subnets.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---

aws_vpc_with_subnets:
  aws_profile: default
  region: eu-west-3
  name: example-vpc-2
  cidr_block: "10.0.0.0/16"
  state: present
  tags:
    #Type: "util"
  state: present
  subnets:
    - az: a
      cidr: "10.0.0.0/24"
      state: present
      assign_instances_ipv6: no
```

<!--ENDROLEVARS-->
