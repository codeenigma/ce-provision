# AWS Security Groups
This is a helper role for managing AWS security groups. Security groups are created in the [`aws_vpc`](https://github.com/codeenigma/ce-provision/tree/2.x/roles/aws/aws_vpc) role, however different roles and modules require different data when working with security groups. This role allows you to feed in a list of security group names and get back, in private variables, the following data for later use in other places:

```yaml
- name: Set up lists.
    ansible.builtin.set_fact:
      _aws_security_groups: [] # a list of all the security group data requested
      _aws_security_group_ids: [] # a list of security group IDs
      _aws_security_group_names: "{{ aws_security_groups.group_names }}" # a list of security group names (in a new var for consistency)
      _aws_security_group_list: [] # a list in the requested format, either a list of names or a list of IDs, so allow for calling a consistent variable name
```

This role is used by other roles to provide a consistent experience for developers, you can always provide a list of security group names, no matter what the module being called within a role requires.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_security_groups:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  group_names:
    - ssh_open
    - web_open
  return_type: ids # can be either 'names' or 'ids'

```

<!--ENDROLEVARS-->
