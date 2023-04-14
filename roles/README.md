# Roles
Ansible roles and group of roles that constitute the deploy stack.
<!--TOC-->
<!--ENDTOC-->

# Required variables for AWS roles
You must pass the following variables into an Ansible play before running it with ce-provision if you intend to use the AWS subset of roles:

* `_aws_profile` - the Boto3 profile to use
* `_aws_region` - the AWS region to act in
