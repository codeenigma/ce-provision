# APACHE

Install and configure the apache webserver.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
php:
  version:
    - 7.2
symfony_env: "{{ _env_type }}"
apache:
  # Global default config for apache2.conf.
  user: www-data
  mods_enabled:
  - rewrite
  - ssl
  - proxy
  - proxy_fcgi
  - fcgid
  http:
    server_names_hash_bucket_size: 256
    access_log: /var/log/apache2-access.log
    error_log: /var/log/apache2-error.log
    error_log_level: "notice"
  # Group prefix. Useful for grouping by environments.
  log_group_prefix: ""
  # Main log stream for apache (Cloudwatch).
  log_stream_name: example
  # We can only have one backend, due to the way we use "common" templates.
  # Moving this per domain means instead having templates per project type.
  php_fastcgi_backend: "127.0.0.1:90{{ php.version[-1] | replace('.', '') }}"
  limit_request_body: "734003200" #700M
  timeout: 120
  max_clients: 256
  max_requests_per_child: 10000
  keepalive: "Off"
  overrides: [] # See the '_overrides' role.
  domains:
    - server_name: "{{ _domain_name }}"
      access_log: "/var/log/apache2/access.log"
      error_log: "/var/log/apache2/error.log"
      error_log_level: "notice"
      # Server specific log stream (Cloudwatch),
      log_stream_name: example
      webroot: "/var/www/html"
      project_type: "flat"
      ssl: # @see the 'ssl' role.
        domain: "{{ _domain_name }}"
        handling: selfsigned
      is_default: true
      basic_auth:
        auth_enabled: false
        auth_user: "hello"
        auth_pass: "P3nguin!"
      servers:
        - port: 80
          ssl: false
          https_redirect: true
        - port: 443
          ssl: true
          https_redirect: false

```

<!--ENDROLEVARS-->
