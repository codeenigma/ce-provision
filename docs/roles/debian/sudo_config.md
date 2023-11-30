# sudo config
Manages sudo permissions. Note, this role does not install any form of `sudo` package, it assumes the required packages are already installed and simply ensures the existance of `/etc/sudoers.d` and places a correctly formatted config file within. If `sudo.entity_name` is not set it will do nothing.

There is good documentation on the `sudoer` format in the Ubuntu documentation, here:
* https://help.ubuntu.com/community/Sudoers

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
sudo_config:
  entity_name: "" # comma separated list of users, sudo user alias or group name, not forgetting to prefix groups with a '%' symbol
  # Defaults compile the following string to give a user passwordless access to all commands on all hosts:
  #   someuser ALL=(ALL) NOPASSWD: ALL
  hosts: "ALL" # can also be a comma separated list of hosts or sudo host alias
  operators: "(ALL)" # can also be a sudo user alias or an empty string
  tags: "NOPASSWD:" # colon separated list of valid sudo tags (NOEXEC, PASSWD, NOPASSWD) with trailing colon, can also be an empty string
  commands: "ALL" # can also be a sudo command alias or a comma separated list (see the `squashfs` role for an example)
  filename: "sudoer" # name of config file in /etc/sudoers.d
```

<!--ENDROLEVARS-->
