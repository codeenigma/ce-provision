# NGINX

Install and configure the NGINX webserver.

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
    sendfile: "on"
    keepalive_timeout: 65
    gzip_vary: "on"
    gzip_types:
      - text/plain
      - text/css
      - text/xml
      - text/javascript
      - application/javascript
      - application/x-javascript
      - application/json
      - application/xml
      - application/xml+rss
      - application/xhtml+xml
      - application/x-font-ttf
      - application/x-font-opentype
      - image/svg+xml
      - image/x-icon
    mime_types:
      text/html: ["html", "htm", "shtml"]
      text/css: ["css"]
      text/xml: ["xml", "rss"]
      image/gif: ["gif"]
      image/jpeg: ["jpeg", "jpg"]
      application/x-javascript: ["js"]
      application/atom+xml: ["atom"]
      text/mathml: ["mml"]
      text/plain: ["txt"]
      text/vnd.sun.j2me.app-descriptor: ["jad"]
      text/vnd.wap.wml: ["wml"]
      text/x-component: ["htc"]
      image/png: ["png"]
      image/tiff: ["tif", "tiff"]
      image/vnd.wap.wbmp: ["wbmp"]
      image/x-icon: ["ico"]
      image/x-jng: ["jng"]
      image/x-ms-bmp: ["bmp"]
      image/svg+xml: ["svg", "svgz"]
      font/ttf: ["ttf"]
      font/opentype: ["otf"]
      application/font-woff: ["woff"]
      application/vnd.ms-fontobject: ["eot"]
      application/java-archive: ["jar", "war", "ear"]
      application/manifest+json: ["webmanifest"]
      application/json: ["json"]
      application/mac-binhex40: ["hqx"]
      application/msword: ["doc"]
      application/pdf: ["pdf"]
      application/postscript: ["ps", "eps", "ai"]
      application/rtf: ["rtf"]
      application/vnd.ms-excel: ["xls"]
      application/vnd.ms-powerpoint: ["ppt"]
      application/vnd.wap.wmlc: ["wmlc"]
      application/vnd.google-earth.kml+xml: ["kml"]
      application/vnd.google-earth.kmz: ["kmz"]
      application/x-7z-compressed: ["7z"]
      application/x-cocoa: ["cco"]
      application/x-java-archive-diff: ["jardiff"]
      application/x-java-jnlp-file: ["jnlp"]
      application/x-makeself: ["run"]
      application/x-perl: ["pl", "pm"]
      application/x-pilot: ["prc", "pdb"]
      application/x-rar-compressed: ["rar"]
      application/x-redhat-package-manager: ["rpm"]
      application/x-sea: ["sea"]
      application/x-shockwave-flash: ["swf"]
      application/x-stuffit: ["sit"]
      application/x-tcl: ["tcl", "tk"]
      application/x-x509-ca-cert: ["der", "pem", "crt"]
      application/x-xpinstall: ["xpi"]
      application/xhtml+xml: ["xhtml"]
      application/zip: ["zip"]
      application/octet-stream: ["bin", "exe", "dll", "deb", "dmg", "iso", "img", "msi", "msp", "msm"]
      application/ogg: ["ogx"]
      audio/midi: ["mid", "midi", "kar"]
      audio/mpeg: ["mpga", "mpega", "mp2", "mp3", "m4a"]
      audio/ogg: ["oga", "ogg", "spx"]
      audio/x-realaudio: ["ra"]
      audio/webm: ["weba"]
      video/3gpp: ["3gpp", "3gp"]
      video/mp4: ["mp4"]
      video/mpeg: ["mpeg", "mpg", "mpe"]
      video/ogg: ["ogv"]
      video/quicktime: ["mov"]
      video/webm: ["webm"]
      video/x-flv: ["flv"]
      video/x-mng: ["mng"]
      video/x-ms-asf: ["asx", "asf"]
      video/x-ms-wmv: ["wmv"]
      video/x-msvideo: ["avi"]

    proxy_buffer_size: 512k
    proxy_buffers: "8 256k"
    client_body_buffer_size: 512k
    fastcgi_buffer_size: 512k
    fastcgi_buffers: "8 256k"
    cache_behavior_private: "add_header Cache-Control \"private, max-age=604800\""
    cache_behavior_public: "add_header Cache-Control \"public, max-age=604800\""
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
  vhost_backup_location: "/home/{{ _ce_provision_username }}" # see _init for _ce_provision_username
  overrides: [] # See the '_overrides' role.
  # Nginx ships a default vhost config that can clash with other services
  # running on port 80. Set this to false to remove it after Nginx installation.
  keep_default_vhost: true
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
        replace_existing: false
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
        # certbot_register_command: "certonly --agree-tos --preferred-challenges http -n"
        # certbot_renew_command: "certonly --agree-tos --force-renew"
        # reload_command: restart
        # reload:
        #   - nginx
        # on_calendar: "Mon *-*-* 04:00:00"
      ratelimitingcrawlers: true
      is_default: true
      is_behind_cloudfront: false # set to true to disable gzip.
      basic_auth:
        auth_enabled: false
        auth_file: "" # optionally provide the path on the deploy server to a htpasswd file - WARNING - it must be valid and will not be checked!
        auth_user: "hello"
        auth_pass: "P3nguin!" # if no password is provided one will be generated automatically and displayed in the build output.
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
