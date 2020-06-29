# AWS RDS 
Creates an RDS instance and associated ressources.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
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
