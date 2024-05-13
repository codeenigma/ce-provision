# AWS Cloudwatch agent

Install and configure the cloudwatch agent.
Note that retention policies can not be set here,
you will have to use the `amazon.aws.cloudwatchlogs_log_group`
module in your playbooks.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_cloudwatch_agent:
  # Stream name.
  log_stream_name: example
  # Namespace for metrics. Leave empty to use the default CWAgent.
  metrics_namespace: example
  # Group prefix. Useful for grouping by environments.
  # Eg. instead of "syslog", you can have "dev syslog", "prod syslog", etc.
  log_group_prefix: ""
  # You'd normally use IAM policies, but that allows
  # non-AWS servers to log in cloudwatch too.
  use_credentials: false
  credentials:
    aws_access_key_id: XXX
    aws_secret_access_key: XXX
    region: eu-west-1 # AWS region name - can be substituted for "{{ _aws_region }}" if set

```

<!--ENDROLEVARS-->
