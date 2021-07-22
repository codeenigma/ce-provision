# EC2 CloudWatch Metric Alarm
Creates an EC2 alarm for CloudWatch. You can use this role to set any alarm, the EC2 AutoScale role
uses it to set autoscaling alarms for autoscaling policies if you need an example.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_ec2_metric_alarm:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  state: present
  name: ""
  description: "Created by Ansible."
  metric: ""
  namespace: "" # The CloudWatch namespace (category) the alarm will appear in.
  statistic: "Average" # Statistical model to apply to the values gathered.
  comparison: ""
  threshold: 75.0 # The min/max bound for triggering the alarm.
  unit: "Percent" # The threshold's unit of measurement.
  period: 2 # The time (in seconds) between metric evaluations.
  evaluation_periods: 2 # The number of times the metric is calculated before final calculation.
  dimensions: {} # Dictionary of metrics the alarm is applied to.
  alarm_actions: [] # List of ARNs of actions to take if the alarm is triggered. An ec2_scaling_policy ARN is a possible action, see aws_ec2_autoscale_cluster.
  insufficient_data_actions: [] # List of ARNs of actions to take if the alarm has insufficient data.
  ok_actions: [] # List of ARNs of actions to take if the alarm is in an OK state.
  treat_missing_data: "missing" # What to do if data is missing (see API docs for options).
```

<!--ENDROLEVARS-->
