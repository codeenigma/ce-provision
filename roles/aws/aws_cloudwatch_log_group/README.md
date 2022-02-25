# Cloudwatch log group

Manage log groups states and retention policies.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_cloudwatch_log_group:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  tags: {}
  state: present
  # Number of days to keep logs, in days.
  # Valid values are: [1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653]
  retention: 365
  # Group names to apply the policy to.
  log_group_names:
    - "syslog"
    - "auth"

```

<!--ENDROLEVARS-->
