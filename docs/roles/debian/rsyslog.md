# Rsyslog

Configures rsyslog in a client/server topology. Note this doesn't allow for any advanced settings,
and will group everything in the main /var/log/syslog file.

<!--ROLEVARS-->
## Default variables
```yaml
---
rsyslog:
  listen_port: 514
  # Either client or server.
  role: client
  # For clients, server name or IP.
  server: my.server.example.com

```

<!--ENDROLEVARS-->
