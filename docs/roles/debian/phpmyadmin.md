# phpMyAdmin
This role only installs phpMyAdmin ready for configuration, it does not do any active configuration, nor does it create the necessary NGINX vhost. It will install `debian/php-fpm` and `debian/nginx` so do review their variables and set what you need prior to running a first build with `phpmyadmin`.

Here is an example NGINX vhost config you can copy to your `nginx.yml` file and adjust as required:

```yaml
nginx:
  domains:
    - server_name: "phpmyadmin.{{ _domain_name }}"
      access_log: "/var/log/nginx/access-phpmyadmin.log"
      error_log: "/var/log/nginx/error-phpmyadmin.log"
      error_log_level: "notice"
      webroot: /home/deploy/deploy/phpmyadmin
      project_type: custom
      ssl:
        domains:
          - "phpmyadmin.{{ _domain_name }}"
        handling: letsencrypt
        http_01_port: 5000
        autorenew: true
        email: sysadm@codeenigma.com
        services: []
        web_server: standalone
        certbot_register_command: "/usr/bin/certbot certonly --agree-tos --preferred-challenges http -n"
        certbot_renew_command: "/usr/bin/certbot certonly --agree-tos --force-renew"
        reload_command: reload
        reload:
          - nginx
        renewal_minute: "0" # minute to run renewal cron job
        renewal_hour: "0" # hour to run renewal cron job
        renewal_weekday: "0" # day of week to run renewal
      ratelimitingcrawlers: true
      is_default: false
      servers:
        - port: 80
          ssl: false
          https_redirect: true
        - port: 443
          ssl: true
      upstreams: []
```

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
phpmyadmin:
  version: 5.2.1 # see https://www.phpmyadmin.net/files/
  method: install # can be changed to 'upgrade' to overwrite an existing installation
  install_path: "/home/{{ ce_deploy.username }}/deploy"
  # Assuming user and group should match php-fpm by default
  www_user: "{{ php.fpm.pool_user }}"
  www_group: "{{ php.fpm.pool_group }}"
```

<!--ENDROLEVARS-->