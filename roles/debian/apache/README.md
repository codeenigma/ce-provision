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
    - 8.1 # see https://www.php.net/supported-versions.php
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
  recreate_vhosts: true # handle vhosts with ansible, if 'true' then clean up 'sites-enabled' dir and run domain.yml
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
        replace_existing: false
        domain: "{{ _domain_name }}"
        handling: selfsigned
        # Sample LetsEncrypt config, because include_role will not merge defaults these all need providing:
        # handling: letsencrypt
        # http_01_port: 80
        # autorenew: true
        # email: sysadm@codeenigma.com
        # services:
        #   - apache2
        # web_server: standalone
        # certbot_register_command: "certonly --agree-tos --preferred-challenges http -n"
        # certbot_renew_command: "certonly --agree-tos --force-renew"
        # reload_command: restart
        # reload:
        #   - apache2
        # on_calendar: "Mon *-*-* 04:00:00"
      is_default: true
      basic_auth:
        auth_enabled: false
        auth_file: ""  # optionally provide the path on the deploy server to a htpasswd file - WARNING - it must be valid and will not be checked!
        auth_user: "hello"
        auth_pass: "P3nguin!" # if no password is provided one will be generated automatically and displayed in the build output.
        auth_message: "Restricted content"
      servers:
        - port: 80
          ssl: false
          https_redirect: true
        - port: 443
          ssl: true
          https_redirect: false

```

<!--ENDROLEVARS-->
