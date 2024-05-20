# AWS ACL
Creates an ACL to be attached to a CloudFront distribution or an Application Load Balancer (ALB).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables for creation of ACL (pass it as a list)
```yaml
---
---
aws_acl:
  - name: example_master_acl
    description: "Master ACL for CF"
    scope: CLOUDFRONT # Can be REGIONAL for ALBs
    region: "us-east-1"
    tags: {}
    rules:
      rate_limit: 200 # set to 0 to skip rate limit rule, set to a value to set how many requests to allow in period before blocking
      botControl: "COMMON" # or set to TARGETED inspection level (comment out to avoid addign rule)

      ip_sets:
        - name: "Allowed-ips-example"
          action: allow
          list: []
            #- 1.1.1.1/32 # list of ip ranges
            #- 2.2.2.2/32
            #- 3.3.3.3/32
        - name: "Blocked-ips-example"
          action: block
          list: []
            #- 4.4.4.4/32 # list of ip ranges
            #- 5.5.5.5/32
            #- 6.6.6.6/32

      cc_block_list: []

      regular_rules:
        - name: allow_panels
          action: allow
          string: "panels/ajax"
          position: "CONTAINS"

#      cyber_sec: #Need to implement task
```

## Default variables for assigning ACL to CF or ALB
```yaml
---
aws_acl:
  name: example_master_acl # Name of the ACL to apply
  scope: CLOUDFRONT # Can be REGIONAL for ALBs
  region: "us-east-1"
```

<!--ENDROLEVARS-->
