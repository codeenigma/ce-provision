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
  #         schedule: '0 2 * * *' # A CRON expression in UTC specifying when the job is initiated.
  #         start_window_cancel: 60 # A value in minutes after a backup is scheduled before a job will be cancelled if it doesn't start successfully.
  #         completion_window_cancel: 360 # A value in minutes after a backup job is successfully started before it must be completed or it will be canceled by Backup.
  #         lifecycle: # The lifecycle defines when a protected resource is transitioned to cold storage and when it expires.
  #           move_to_cold_storage_after_days: 0 # Specifies the number of days after creation that a recovery point is moved to cold storage.
  #           delete_after_days: 35 # Specifies the number of days after creation that a recovery point is deleted.
  #         copy_actions:
  #           copy: false # If you want to copy the backups from this plan to another region, set to true.
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
  #           copy: false # If you want to copy the backups from this plan to another region, set to true.
  #           lifecycle: # The lifecycle defines when a protected resource is transitioned to cold storage and when it expires.
  #             move_to_cold_storage_after_days: 0 # Specifies the number of days after creation that a recovery point is moved to cold storage.
  #             delete_after_days: 0 # Specifies the number of days after creation that a recovery point is deleted.
  #         continuous_backup: false # Specifies whether Backup creates continuous backups.
  #     resources:
  #       efs: true
  #       rds: true
  #       ebs: true
  #       ec2: false
  backup:
    backup_plan_id: ""
    resource_name: ""
    resource_arn: ""

```

<!--ENDROLEVARS-->
