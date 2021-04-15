# \_overrides.

Allow some files and symlinks to be created or replaced on the target server.
Usually not called by itself, but triggered by other roles relying on it.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_overrides:
  # A list of files to override.
  files: []
  # files:
  #   - src: "php/php.ini" # This is relative to the "extra" config, or to the playbook.
  #     dest: "/etc/php7.4/fpm/php.ini"
  #     mode: "0755"
  #     owner: "root"
  #     group: "root"
  links: []
  # links:
  #   - src: "/mnt/assets" # This is absolute, on the target.
  #     dest: "/var/www/static"
  #     mode: "0755"
  #     owner: "nginx"
  #     group: "nginx"

```

<!--ENDROLEVARS-->
