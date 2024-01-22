# Swap
General role to add swap space to servers. By default, role is set to add 4G of swap space. As a general rule of thumb, swap should be set to 2.5 times the amount of RAM. So if a server has 2G RAM, we should set swap to 5G by setting `size: "5G"` in the variables for that server.
Make sure to match count var with size, otherwise if you leave count var at 2048 and set swap to 8G it will set up 2G swap.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
swap:
  count: 4096
  size: "4G"
  swap_space: swapfile

```

<!--ENDROLEVARS-->
