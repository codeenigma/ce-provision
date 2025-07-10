# Packer
Role to install Hashicorp's Packer binary.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
packer:
  version: "1.11.2" # see https://releases.hashicorp.com/packer/
  plugins:
    - github.com/hashicorp/amazon
    - github.com/hashicorp/ansible

```

<!--ENDROLEVARS-->
