# NGINX

Install and configure the nginx webserver.

Note, the directives are mostly DENY FIRST so if you're expecting to find config that blocks a certain file extension or pattern you should consider it the other way and ensure that pattern is not *allowed* anywhere.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
# We might not want to install PHP, but we do need the version variable for templates, hence including this.
# Default version should track the php-common role.
php:
  version:
    - 8.1 # see https://www.php.net/supported-versions.php
symfony_env: "{{ _env_type }}"
# Nginx variables actually start here.
nginx:
  # Global default config for nginx.conf.
  user: www-data
  worker_processes: auto
  events:
    worker_connections: 768
  http:
    server_names_hash_bucket_size: 256
    access_log: /var/log/nginx-access.log
    error_log: /var/log/nginx-error.log
    ssl_protocols: "TLSv1.2 TLSv1.3"
    proxy_host: localhost
    proxy_port: 8443
    # You can inject custom directives into the main nginx.conf file here by providing them as a list of strings.
    #custom_directives: []
  # Group prefix. Useful for grouping by environments.
  log_group_prefix: ""
  # Main log stream for nginx (Cloudwatch).
  log_stream_name: example # We can only have one backend, due to the way we use "common" templates, moving this per domain means instead having templates per project type.
  # See php.fpm.unix_socket, if true use a socket here:
  php_fastcgi_backend: "127.0.0.1:90{{ php.version[-1] | replace('.', '') }}" # for unix socket use "unix:/var/run/php{{ php.version[-1] | replace('.','') }}-fpm.sock"
  ratelimitingcrawlers: false
  client_max_body_size: "700M"
  fastcgi_read_timeout: 60
  recreate_vhosts: true # handle vhosts with ansible, if 'true' then clean up 'sites-enabled' dir and run domain.yml.
  overrides: [] # See the '_overrides' role.
  domains:
    - server_name: "{{ _domain_name }}"
      access_log: "/var/log/nginx/access.log"
      error_log: "/var/log/nginx/error.log"
      error_log_level: "notice"
      access_log_format: "main"
      # Server specific log stream (Cloudwatch),
      log_stream_name: example
      webroot: "/var/www/html"
      project_type: "flat"
      ssl: # @see the 'ssl' role.
        domains:
          - "{{ _domain_name }}"
        handling: selfsigned
        # Sample LetsEncrypt config, because include_role will not merge defaults these all need providing:
        # handling: letsencrypt
        # http_01_port: 5000
        # autorenew: true
        # email: sysadm@codeenigma.com
        # services: []
        # web_server: standalone
        # certbot_register_command: "/usr/bin/certbot certonly --agree-tos --preferred-challenges http -n"
        # certbot_renew_command: "/usr/bin/certbot certonly --agree-tos --force-renew"
        # reload_command: restart
        # reload:
        #   - nginx
      ratelimitingcrawlers: true
      is_default: true
      basic_auth:
        auth_enabled: false
        auth_user: "hello"
        auth_pass: "P3nguin!"
        auth_message: Restricted content
      servers:
        - port: 80
          ssl: false
          https_redirect: true
          # You can inject custom directives into any server block in any vhost here by providing them as a list of strings.
          #custom_directives: []
        - port: 443
          ssl: true
          https_redirect: false
          #custom_directives: []
      upstreams: []
      # upstreams:
      #   - name: 'backend_example'
      #     backends:
      #       - 142.42.64.2:8080
      #       - 142.42.64.3:8080

```

<!--ENDROLEVARS-->
