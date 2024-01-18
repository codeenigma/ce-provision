# General swap role to add swap space

By default, role is set to add 2G of swap space.
As a general rule of thumb, swap should be set to 2x of current RAM.
If server has 2G RAM, set RAM to 5G by creating swap.yml inside vars at local directory.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
swap:
  count: 2048
  size: "4G"
  swap_space: swapfile

```

<!--ENDROLEVARS-->
