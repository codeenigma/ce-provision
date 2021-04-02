# AWS client

Installs AWS tools (Cloudwatch, SSM, ...) on servers. Servers can theoretically be anywhere, they do not have to be AWS EC2 instances.

The server will need some IAM permissions, either through:

- an IAM role (see aws/aws_iam_role), the standard for EC2 instances.
- an IAM user (see aws/aws_credentials), for non-AWS servers.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
<!--ENDROLEVARS-->
