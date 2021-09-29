# AWS Backup

Creates AWS Backup vaults and plans. Resources are assigned to these plans, if the variable is set, in the other roles, such as `aws/aws_efs` and `aws/aws_rds`.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_backup:
  vault:
    name: "Default" # Set the vault name; if anything but 'default', a vault will be created with the name specified and the encryption key below.
    encryption_key: "Default" # An Amazon Resource Name (ARN) that identifies the encryption key to use in the copy region. If 'default', the default AWS encryption key will be used. If NOT 'default', the key must already exist so the ARN can be passed in.
  copy_vault: {} # If empty, backups won't be copied to another region. See below for usage example.
  # copy_vault:
  #   name: "Default"
  #   encryption_key: "Default" # An Amazon Resource Name (ARN) that identifies the encryption key to use in the copy region. If 'default', the default AWS encryption key will be used. If NOT 'default', the key must already exist so the ARN can be passed in.
  #   region: "eu-central-1"
  plans: [] # A list of backup plans. See below for usage example.
  # plans:
  #   - name: "ExampleDev"
  #     rules:
  #       - rule_name: "DailyBackups"
  #         schedule: '0 2 ? * * *' # A CRON expression in UTC specifying when the job is initiated. ? is in the 'Day of month' position as * cannot be used and it appears Backup uses the year field.
  #         start_window_cancel: 60 # A value in minutes after a backup is scheduled before a job will be cancelled if it doesn't start successfully.
  #         completion_window_cancel: 360 # A value in minutes after a backup job is successfully started before it must be completed or it will be canceled by Backup.
  #         lifecycle: # The lifecycle defines when a protected resource is transitioned to cold storage and when it expires.
  #           move_to_cold_storage_after_days: 0 # Specifies the number of days after creation that a recovery point is moved to cold storage.
  #           delete_after_days: 35 # Specifies the number of days after creation that a recovery point is deleted.
  #         copy_actions:
  #           offsite: false # If you want to copy the backups from this plan to another region, set to true.
  #           lifecycle: # The lifecycle defines when a protected resource is transitioned to cold storage and when it expires.
  #             move_to_cold_storage_after_days: 0 # Specifies the number of days after creation that a recovery point is moved to cold storage.
  #             delete_after_days: 0 # Specifies the number of days after creation that a recovery point is deleted.
  #         continuous_backup: false # Specifies whether Backup creates continuous backups.
  #       - rule_name: "Monthly"
  #         schedule: '0 0 1 * *' # A CRON expression in UTC specifying when the job is initiated.
  #         start_window_cancel: 60 # A value in minutes after a backup is scheduled before a job will be cancelled if it doesn't start successfully.
  #         completion_window_cancel: 360 # A value in minutes after a backup job is successfully started before it must be completed or it will be canceled by Backup.
  #         lifecycle: # The lifecycle defines when a protected resource is transitioned to cold storage and when it expires.
  #           move_to_cold_storage_after_days: 30 # Specifies the number of days after creation that a recovery point is moved to cold storage.
  #           delete_after_days: 365 # Specifies the number of days after creation that a recovery point is deleted.
  #         copy_actions:
  #           offsite: false # If you want to copy the backups from this plan to another region, set to true.
  #           lifecycle: # The lifecycle defines when a protected resource is transitioned to cold storage and when it expires.
  #             move_to_cold_storage_after_days: 0 # Specifies the number of days after creation that a recovery point is moved to cold storage.
  #             delete_after_days: 0 # Specifies the number of days after creation that a recovery point is deleted.
  #         continuous_backup: false # Specifies whether Backup creates continuous backups.
  backup:
    iam_role_arn: "Default" # Set to the ARN of an existing IAM role or leave as 'Default' to use the AWSBackupDefaultServiceRole role.
    backup_plan_name: "" # Name of the backup plan to use. Must match one in the plans list.
    selection_name: "" # Name of the resource assignation; this is set in the roles which create the resources such as aws/aws_ec2_with_eip and aws/aws_efs.
    resource_id: "" # The unique ID of the resource. For EC2, this is the instance ID. For EFS, the filesystem ID. For RDS, the DB identifier.
    resource_type: "" # Options are 'instance', 'file-system' and 'db' for EC2, EFS and RDS respectively.
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
```

<!--ENDROLEVARS-->
