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
  region: "{{ _aws_region }}"
  # If you intend to have RDS instances you must provide at least two subnets.
  subnets:
    - cidr_block: "10.0.0.0/24"
      # ipv6_cidr_block: "1" # This will create something like xxxx:xxxx:xxxx:xxyy::/64 where yy is created using the ansible.utils.ipsubnet filter automatically - DO NOT DEFINE IF IPV6 IS NOT REQUIRED
      az: b
      assign_instances_ipv6: false # if true, need to specify an ipv6_cidr_block value.
      # A NAT gateway to associate with the subnets.
      # @todo IPV6
      nat_ipv4: false
      name: example.
      # Wether to create a dedicated security group allowing internal traffic.
      security_group: false
  tags: {}
    #Type: "util"
  state: present

```

<!--ENDROLEVARS-->
