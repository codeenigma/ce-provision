# AWS ACL
Creates an ACL to be attached to a CloudFront distribution or an Application Load Balancer (ALB).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
rate_limit: 0 # set to 0 to skip rate limit rule, set to a value to set how many requests to allow in period before blocking
aws_acl:
  name: example_master_acl
  scope: CLOUDFRONT # Can be REGIONAL for ALBs
  tags: {}

  botControl: true
  inspection: "COMMON" # or set to TARGETED inspection level

  ip_allow:
    name: "Allowed-ips"
    list: []
      #- 1.1.1.1/32 # list of ip ranges
      #- 2.2.2.2/32
      #- 3.3.3.3/32

  ip_block:
    name: "Blocked-ips"
    list: []
      #- 4.4.4.4/32 # list of ip ranges
      #- 5.5.5.5/32
      #- 6.6.6.6/32

  cc_block_list: []
    #- BY # Belarus
    #- CN # China
    #- IR # Iran
    #- SA # Saudi Arabia
```

<!--ENDROLEVARS-->