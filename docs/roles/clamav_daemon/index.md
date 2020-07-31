# ClamAV Daemon

<!--TOC-->
<!--ENDTOC-->
## Configuration
This role will install the ClamAV daemon. If you want to install clamscan and generate reports check the clamav_clamscan role.

<!--ROLEVARS-->
## Default variables
```yaml
---
# defaults file for clamav

clamav_daemon:

  host: '127.0.0.1'
  port: '3310'

```

<!--ENDROLEVARS-->
