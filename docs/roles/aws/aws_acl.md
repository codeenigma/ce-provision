# AWS ACL
Creates an ACL to be attached to a CloudFront distribution or an Application Load Balancer (ALB).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_acl:
  - name: example_master_acl
    description: "Master ACL for CF"
    scope: CLOUDFRONT # Can be REGIONAL for ALBs
    region: "us-east-1"
    tags: {}
    rules:
      rate_limit:
        value: 200 # set to 0 to skip rate limit rule, set to a value to set how many requests to allow in period before blocking
<<<<<<< HEAD
        priority: 2 # can be float with 1 decimal place
      ip_sets:
        - name: "Allowed-ips"
          action: allow
          priority: 1 # can be float with 1 decimal place
=======
        priority: 2
      ip_sets:
        - name: "Allowed-ips"
          action: allow
          priority: 1
>>>>>>> Adding-aws-acl-to-meta
          list: [] # If the list is empty, ip set won't be recreated
            #- 1.1.1.1/32 # list of ip ranges
            #- 2.2.2.2/32
            #- 3.3.3.3/32
        - name: "Blocked-ips"
          action: block
          priority: 0
          list: [] # If the list is empty, ip set won't be recreated
            #- 4.4.4.4/32 # list of ip ranges
            #- 5.5.5.5/32
            #- 6.6.6.6/32
      country_codes:
        - name: "allowed-countries"
          action: allow
<<<<<<< HEAD
          priority: 0.2
=======
          priority: 7
>>>>>>> Adding-aws-acl-to-meta
          list:
            - GB
            - HR
        - name: "blocked-countries"
          action: block
          priority: 8
          list:
            - RU
            - CN
      regular_rules:
        - name: allow_panels
          action: allow
          statements_type: "single" # supported "and", "or" and "not" ("and" and "or" supports multiple statements)
          priority: 4
          statements:
            - inspect: "UriPath" # Aslo supported: "SingleHeader"
              position: "CONTAINS"
              string: "panels/ajax"
              text_trans: "NONE"
        - name: block_bots
          action: block
          statements_type: "or" # supported "and", "or" and "not" ("and" and "or" supports multiple statements)
          priority: 5
          statements:
            - inspect: "SingleHeader" # Aslo supported: "SingleHeader"
              position: "CONTAINS"
              string: "spider"
              text_trans: "LOWERCASE"
            - inspect: "SingleHeader" # Aslo supported: "SingleHeader"
              position: "CONTAINS"
              string: "bot"
              text_trans: "LOWERCASE"
            - inspect: "SingleHeader" # Aslo supported: "SingleHeader"
              position: "CONTAINS"
              string: "crawl"
              text_trans: "LOWERCASE"
      # Managed rules list
      bot_control:
        enabled: false
        target: "COMMON" # or set to TARGETED inspection level (comment out to avoid addign rule)
        priority: 3
      cyber_sec:
        enabled: false # Need to subscribe first in AWS
        rule_list: []
        priority: 6
      amazon_ip_reputation:
        enabled: false
        rule_list: []
        priority: 9
      common_rule_set:
        enabled: false
        rule_list: []
        priority: 10
      php_rule_set:
        enabled: false
        rule_list: []
        priority: 11
      known_bad_inputs:
        enabled: false
        rule_list: []
        priority: 12
      anonymous_ip_list:
        enabled: false
        rule_list: []
        priority: 13

```

<!--ENDROLEVARS-->
