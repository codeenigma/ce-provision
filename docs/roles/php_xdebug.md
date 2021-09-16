# PHP XDebug

Installs and configure XDebug extension for PHP

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
xdebug:
  cli: false
  fpm: false
  scream: 0
  max_nesting_level: 1024
  mode: "debug"
  start_with_request: "trigger"
  output_dir: "/var/log/php/xdebug"
  remote_port: "9003"
  # The "auto" behaviour tries to guess the best setting for when in use with ce-dev.
  # You can of course set it explicitely to the relevant value for your use case.
  remote_host: auto # Default to docker.for.mac.localhost when used in ce-dev on a Mac OS host, and to 127.0.0.1 in all other cases.
  remote_connect_back: auto # Default to 0 when used in ce-dev on a Mac OS host, and to 1 in all other cases.
```

<!--ENDROLEVARS-->
