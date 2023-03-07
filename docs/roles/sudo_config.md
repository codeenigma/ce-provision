# sudo config
Manages sudo permissions. Note, this role does not install any form of `sudo` package, it assumes the required packages are already installed and simply ensures the existance of `/etc/sudoers.d` and places a correctly formatted config file within. If `sudo.entity_name` is not set it will do nothing.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
sudo_config:
  entity_name: "" # user or group name, not forgetting to prefix groups with a '%' symbol
  commands: "ALL" # can also be a comma separated list, see the `squashfs` role for an example
  filename: "sudoer" # name of config file in /etc/sudoers.d
```

<!--ENDROLEVARS-->
