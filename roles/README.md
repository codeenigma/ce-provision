# Roles
Ansible roles and group of roles that constitute the deploy stack.

<!--TOC-->
<!--ENDTOC-->

## Required variables
All environments require the following variable to be set by CI or at the terminal command:
* `_env_type` - the type of environment, e.g. development, production, etc.

## Required variables for AWS roles
You must pass the following additional variables into an Ansible play before running it with ce-provision if you intend to use the AWS subset of roles:
* `_aws_profile` - the Boto3 profile to use
* `_aws_region` - the AWS region to act in
* `_aws_resource_name` - the name of the variables directory, which will match the Ansible host group created by the AWS discovery plugin

Please also read carefully the AWS README file at `docs/roles/AWS.md`.
