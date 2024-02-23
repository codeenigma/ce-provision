# AWS RDS
Creates an RDS instance and associated ressources.

If the `engine` variable is set to **aurora-mysql**, you'll need to manually create the Aurora cluster first. Typically, a controller will already exist, so something like this can be run from the controller:

```
AWS_PROFILE=example aws rds create-db-cluster --db-cluster-identifier example-aurora-cluster --engine aurora-mysql --engine-version 5.7.mysql_aurora.2.10.2 --db-subnet-group-name example-aurora --vpc-security-group-ids sg-abcdefghijklmnop --storage-encrypted --master-username "auroradev" --master-user-password "aurora12345"
```

You'll need to have created the subnet group first as well as the security groups.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_rds:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  multi_az: true
  # You must provide at least two subnets in two different AZs, even for single AZ deployments.
  subnets:
    - subnet-aaaaaaaa
    - subnet-bbbbbbbb
  name: example
  tags: {}
  db_instance_class: db.t3.medium
  state: present
  description: example
  engine: mariadb
  # In an Aurora cluster reader and writer can swap role at any time, so by default we name them 'blue' and 'green'
  aurora_suffix: blue # appended to cluster name to create a unique instance name for the first (initially write) instance
  aurora_reader: false # If true, an Aurora reader instance will be created.
  aurora_reader_suffix: green # appended to cluster name to create unique instance name for the second (initially read-only) instance - must not match aurora_suffix
  # engine_version: '5.7.2' # Omit to use latest.
  # See parameter group docs: https://docs.ansible.com/ansible/latest/collections/community/aws/rds_param_group_module.html
  # db_parameter_group_name: "example" # Omit to use default
  # db_parameter_group_description: "Custom parameter group" # Description of parameter group
  # db_parameter_group_engine: "mariadb10.5" # accepts different values to RDS instance 'engine'
  # db_parameters: {} # dictionary of available parameters
  allocated_storage: 100 # Initial size in GB. Minimum is 100.
  max_allocated_storage: 1000 # Max size in GB for autoscaling.
  storage_encrypted: false # Whether to encrypt the RDS instance or not.
  master_username: hello # The name of the master user for the DB cluster. Must be 1-16 letters or numbers and begin with a letter.
  master_user_password: hellothere
  publicly_accessible: false # Wether to allocate an IP address
  security_groups: [] # list of security group names, converted to IDs by aws_security_groups role
  rds_cloudwatch_alarms: # name will have the RDS identifier prepended.
    - name: "example_free_storage_space_threshold_{{ _env_type }}_asg"
      description: "Average database free storage space over the last 10 minutes too low."
      metric: "FreeStorageSpace"
      namespace: "AWS/RDS"
      statistic: "Average"
      threshold: 20000000000
      unit: "Bytes"
      comparison: "LessThanOrEqualToThreshold"
      period: 600
      evaluation_periods: 1
    - name: "example_cpu_utilization_too_high_{{ _env_type }}_asg"
      description: "Average database CPU utilization over last 10 minutes too high."
      metric: "CPUUtilization"
      namespace: "AWS/RDS"
      statistic: "Average"
      threshold: 65
      unit: "Percent"
      comparison: "GreaterThanOrEqualToThreshold"
      period: 600
      evaluation_periods: 1
    - name: "example_freeable_memory_too_low_{{ _env_type }}_asg"
      description: "Average database freeable memory over last 10 minutes too low, performance may suffer."
      metric: "FreeableMemory"
      namespace: "AWS/RDS"
      statistic: "Average"
      threshold: 100000000
      unit: "Bytes"
      comparison: "LessThanThreshold"
      period: 600
      evaluation_periods: 1
    - name: "example_disk_queue_depth_too_high_{{ _env_type }}_asg"
      description: "Average database disk queue depth over last 10 minutes too high, performance may suffer."
      metric: "DiskQueueDepth"
      namespace: "AWS/RDS"
      statistic: "Average"
      threshold: 64
      unit: "Count"
      comparison: "GreaterThanThreshold"
      period: 600
      evaluation_periods: 1
    - name: "example_swap_usage_too_high_{{ _env_type }}_asg"
      description: "Average database swap usage over last 10 minutes too high, performance may suffer."
      metric: "SwapUsage"
      namespace: "AWS/RDS"
      statistic: "Average"
      threshold: 256000000
      unit: "Bytes"
      comparison: "GreaterThanThreshold"
      period: 600
      evaluation_periods: 1
  sns:
    sns: false
    name: "Notify-Email"
    display_name: "" # Display name for the topic, for when the topic is owned by this AWS account.
    delivery_policy_default_healthy_retry_policy_min_delay_target: 20
    delivery_policy_default_healthy_retry_policy_max_delay_target: 20
    delivery_policy_default_healthy_retry_policy_num_retries: 3
    delivery_policy_default_healthy_retry_policy_num_max_delay_retries: 0
    delivery_policy_default_healthy_retry_policy_num_no_delay_retries: 0
    delivery_policy_default_healthy_retry_policy_num_min_delay_retries: 0
    delivery_policy_default_healthy_retry_policy_backoff_function: "linear"
    delivery_policy_disable_subscription_overrides: false
    subscriptions:
      - endpoint: "admin@example.com"
        protocol: "email"
  backup: "{{ _infra_name }}-{{ _env_type }}" # Name of the AWS Backup plan to use to backup the instance.

```

<!--ENDROLEVARS-->
