# AWS Backup Validation

Creates AWS Restore testing plan for EC2 and RDS, EventBridge rule that gets triggered by restore testing and Lambda backup validation that will check and notify about the restored instance.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_backup_validation:
  name: 'RestoreValidation'
  description: 'Restore validation for'
  timeout: 60
  runtime: python3.12
  handler: "lambda_handler"
  resources:
    - EC2
    - RDS
    #- EFS

```

<!--ENDROLEVARS-->
