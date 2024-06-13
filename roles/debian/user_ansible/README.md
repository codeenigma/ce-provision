# User Ansible
General role to create Linux users and corresponding keys, groups, home directory, etc. You may call this role directly or it can be imported, such as when called by the `user_provision` and `user_deploy` roles for handling our system users.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_user_ansible_username: ""
user_ansible:
  # This sets both username and main group.
  username: "{{ _user_ansible_username }}"
  home: "/home/{{ _user_ansible_username }}"
  create: true # if you know the user already exists, set this to false to not create the user.
  create_home: true
  # Optional Linux uid and gid for user
  # uid: 999
  # gid: 999
  # Local username of the deploy user.
  utility_host: "localhost"
  utility_username: ""
  sudoer:
    false
  # List of additional groups to add the user to.
  groups: []
  # List of SSH pub keys to authorize. These must be provided as strings (content of the pub key).
  ssh_keys: []
  # List of SSH private keys to add to server. These must be provided as strings (content of the private key).
  # Be sure to store securely using SOPS or similar.
  ssh_private_keys: []
  # List of hostnames to add to known_hosts.
  known_hosts: []
  # Whether or not to hash any provided hosts for known_hosts.
  known_hosts_hash: true

```

<!--ENDROLEVARS-->
