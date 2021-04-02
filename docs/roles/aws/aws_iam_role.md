# AWS IAM EC2

Set up an IAM role, with basic document/trust policy.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_iam_role:
  name: "example"
  aws_profile: "{{ _aws_profile }}"
  region: "eu-west-3"
  # Pass either names or ARNs for the role.
  managed_policies: []
  # Which document policy to apply.
  # Only EC2 is implemented for now.
  policy_document: ec2
  tags:
    #Type: "util"
  state: present
  _result: {}

```

<!--ENDROLEVARS-->
