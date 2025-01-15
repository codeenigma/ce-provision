# AWS ACL
Creates an ACL to be attached to a CloudFront distribution or an Application Load Balancer (ALB).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables to create WAF
If the var is list type, it will go through the process of creating and assignng rules to WAF
aws_acl.yml needs to be located in global or regional vars

If you don't need one of the rules on the WAF, we can just remove it from the "rules"

Since IP set is a thing under WAF, we have option to create, update and use existing set:

IP set with a list of IPs will be marked as a thing that needs to be created/updated

If its defined only with rule_name, set_name, action and priority (leaving the list empty) it will just search existing set and assign it to WAF
```yaml
removed or
```

```yaml
---
aws_acl:
  - name: "{{ _infra_name }}_main_acl"
    description: "ACL rules from ce-provision-config"
    scope: CLOUDFRONT # Can be REGIONAL for ALBs
    region: "us-east-1"
    tags: "{{ _aws_tags }}"
    recreate: false # set to true to creating the ACL
    rules:
      rate_limit:
        value: 600 # set to 0 to skip rate limit rule, set to a value to set how many requests to allow in period before blocking
        priority: 2 # can be float with 1 decimal place
      ip_sets: []
#   Example IP set to allow a list of safe IPs
#        - rule_name: "Allowed-IPs-rule"
#          set_name: "Allowed-IPs-set"
#          description: "List of IPs to safelist - Ansible managed"
#          action: allow
#          priority: 1
#          list:
#            - 1.1.1.1/32
#            - 2.2.2.2/32
#            - 30.30.30.0/24
#   Example country code ruleset allowing one set of countries and blocking another
#      country_codes:
#        - name: "allowed-countries"
#          action: allow
#          priority: 0.2
#          list:
#            - GB
#            - HR
#            - FR
#            - ES
#            - UY
#            - JP
#        - name: "blocked-countries"
#          action: block
#          priority: 8
#          list:
#            - RU
#            - CN
      regular_rules:
        - name: allow_panels
          action: allow
          statements_type: "single" # supported "single", "and", "or" and "not" ("and" and "or" supports multiple statements)
          priority: 4
          statements:
            - inspect: "UriPath" # Use: "SingleHeader" or "UriPath"
              position: "CONTAINS"
              string: "panels/ajax"
              text_trans: "NONE"
#   Example for multi header block
#        - name: block_bots
#          action: block
#          statements_type: "or" # supported "single", "and", "or" and "not" ("and" and "or" supports multiple statements)
#          priority: 5
#          statements:
#            - inspect: "SingleHeader" # Use: "SingleHeader" or "UriPath"
#              position: "CONTAINS"
#              string: "spider"
#              text_trans: "LOWERCASE"
#            - inspect: "SingleHeader" # Use: "SingleHeader" or "UriPath"
#              position: "CONTAINS"
#              string: "bot"
#              text_trans: "LOWERCASE"
#            - inspect: "SingleHeader" # Use: "SingleHeader" or "UriPath"
#              position: "CONTAINS"
#              string: "crawl"
#              text_trans: "LOWERCASE"
      # Managed rules list
      bot_control:
        enabled: false
        target: "COMMON" # "COMMON" or "TARGETED" inspection level
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
## Default variables to Assign WAF to CF/ALB
If the var is dict type, it will go through the process assignng WAF to CF/ALB
aws_acl.yml needs to be located in resource vars

Make sure to use "us-east-1" for CLOUDFRONT scope
or define region where the ALB is located with REGIONAL scope
```yaml
---
aws_acl:
  name: "{{ _infra_name }}_main_acl"
  scope: CLOUDFRONT # Can be REGIONAL for ALBs
  region: "us-east-1"
```
<!--ENDROLEVARS-->
