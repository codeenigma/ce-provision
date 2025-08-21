# AWS Backup Validation

Creates AWS Restore testing plan for EC2 and RDS, EventBridge rule that gets triggered by restore testing and Lambda backup validation that will check and notify about the restored instance.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_backup_validation:
  s3_bucket: "{{ _general_bucket }}"
  s3_bucket_prefix: "backup-validation" # Prefix used for storing backup validation info
  name: "RestoreValidation"
  description: "Restore validation is running every Sunday at 00:00AM, and validation reporting is triggered on Monday 00:00AM"
  timeout: 60
  runtime: "python3.12"
  handler: "lambda_handler"
  resources:
    - EC2
    - RDS
    #- EFS

```

<!--ENDROLEVARS-->
