# Update main route for a given VPC
This will add/update routes on the "main" route table for a given VPC, leaving existing routes for different CIDR blocks intact.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_vpc_main_route:
  aws_profile: default
  region: eu-west-3
  # tags:
  #   Name: "example"
  vpc_id: vpc-XXX
  # See https://docs.ansible.com/ansible/latest/modules/ec2_vpc_route_table_module.html#parameter-routes
  routes:
    - dest: "10.0.0.0/16" # CIDR block for the route.
      gateway_id: igw-XXX

```

<!--ENDROLEVARS-->
