# VPC
Creates a VPC and associated subnets.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_vpc:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  name: example-vpc-2
  cidr_block: "10.0.0.0/16"
  # ipv6_cidr: true # uncomment to request an Amazon-provided IPv6 CIDR block with /56 prefix length.
  tags: {}
    #Type: "util"
  state: present
  assign_instances_ipv6: false
  security_groups:
    []
    # - name: web - open
    #   description: Allow all incoming traffic on ports 80 and 443
    #   rules:
    #     - proto: tcp
    #       ports:
    #         - 80
    #         - 443
    #       cidr_ip: 0.0.0.0/0
    #       rule_desc: Allow all incoming traffic on ports 80 and 443

```

<!--ENDROLEVARS-->
