# varnish-config
Installs and configures Varnish, with 6.4 being the default version. Depends on geerlingguy.varnish which does the setup bit, varnish-config handles the default.vcl file.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
varnish_config:
  # List of IPs that are allowed to ask for content purge.
  allowed_purge_IP: []
  # Paths that won't be cached.
  bypass_cache_paths: install\.php|update\.php|cron\.php
  # Set this to the actual host you want to force instead of false.
  forced_host_header: false
  pipe_large_assets: false
  # If needed, set the two following variables to true and the actual host you want to redirect to.
  redirect_host: false
  redirect_host_destination: ""
  strip_cookies: (^|;\s*)(_[_a-z]+|has_js|AWSELB|cookie-agreed)=[^;]*
  # List of upstream proxies we trust to set X-Forwarded-For correctly, use either CIDR or list all the IPs.
  upstream_proxies: []

```

<!--ENDROLEVARS-->
