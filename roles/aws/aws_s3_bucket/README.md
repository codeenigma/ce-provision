# AWS S3 Bucket

Creates an S3 bucket and a matching policy.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_s3_bucket:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  name: "example"
  tags:
    Name: "example"
  state: "present"
  _result: {}

```

<!--ENDROLEVARS-->
