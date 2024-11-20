# System
This role provides a means of applying system variables to servers.
Currently, the following entities can be managed with the role:

- Force IPv4 (noipv6)
- Force Static IP configuration for Hetzner Cloud systems (nohetznerdhcp)

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
system:
  noipv6: false
  nohetznerchdp: false

```

<!--ENDROLEVARS-->

