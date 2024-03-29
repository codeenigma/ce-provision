# AWS SNS
Creates an SNS topic and subscription.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_sns:
  name: "alarms" # Name of the topic.
  region: "{{ _aws_region }}" # The region to create the SNS topic.
  display_name: "" # Display name for the topic, for when the topic is owned by this AWS account.
  purge_subscriptions: true # Purge subscriptions not specified in the subscriptions list.
  policy: "" # A dictionary containing the policy to use when creating the topic
  delivery_policy_default_healthy_retry_policy_min_delay_target: 20
  delivery_policy_default_healthy_retry_policy_max_delay_target: 20
  delivery_policy_default_healthy_retry_policy_num_retries: 3
  delivery_policy_default_healthy_retry_policy_num_max_delay_retries: 0
  delivery_policy_default_healthy_retry_policy_num_no_delay_retries: 0
  delivery_policy_default_healthy_retry_policy_num_min_delay_retries: 0
  delivery_policy_default_healthy_retry_policy_backoff_function: "linear"
  delivery_policy_disable_subscription_overrides: false
  subscriptions: [] # A list of subscriptions.
  # subscriptions:
  #   - endpoint: "admin@example.com"
  #     protocol: "email" # email or sms for now.

```

<!--ENDROLEVARS-->
