# Init role

This is meant to ALWAYS be included as the first task of a play.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_init:
  # A list of var directories to include. We only support .yml extensions.
  # This is used to detect if the playbook must re-run or not.
  vars_dirs: []

```

<!--ENDROLEVARS-->
