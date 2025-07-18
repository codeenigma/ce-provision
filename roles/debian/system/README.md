# System
This role provides a means of applying system variables to servers.
Currently, the following entities can be managed with the role:

- Force IPv4 (noipv6)
- Force Static IP configuration for Hetzner Cloud systems (nohetznerdhcp)
- Enable data collection for sysstat

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
system:
  noipv6: false
  nohetznerdhcp: false

```

<!--ENDROLEVARS-->
