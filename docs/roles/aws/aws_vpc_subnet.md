# VPC
Creates a VPC and associated subnets.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_vpc_subnet:
  vpc_id: vpc-XXXX # One of vpc_id or vpc_name is mandatory.
  # vpc_name: example-vpc
  aws_profile: "{{ _aws_profile }}"
  region: eu-west-3
  subnets:
    - cidr_block: "10.0.0.0/24"
      az: b
      assign_instances_ipv6: false
      # A NAT gateway to associate with each of the subnets.
      # This will make the subnet use its own route table.
      # When set to no, subnets inherit the main VPC's route table.
      # @todo IPV6
      nat_ipv4: false
      name: example.
  tags:
    #Type: "util"
  state: present

```

<!--ENDROLEVARS-->
