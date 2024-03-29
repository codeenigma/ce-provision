# Mailpit
[Mailpit](https://mailpit.axllent.org) provides a dummy SMTP mail server and a HTTP interface for checking email so you can verify email is functional in an application without actually sending it out. This is particularly handy in dev and testing environments, as well as on local development environments.

The defaults will install Mailpit as a service and start it with SMTP on port 1025 and the web UI on port 8025. Don't forget, for access to the web UI you will need to open the firewall port. By default the web UI is on port 8025.

The role will also attempt to create a self-signed SSL certificate for Mailpit unless you set `mailpit.create_cert` to `false`. If you already have an SSL certificate you may do this and provide the paths to cert and key and, as long as `mailpit.https` is set to `true` the service will try to start with the specified cert and key. There are also ready defaults for LetsEncrypt commented out.

If you set `mailpit.service` to `false` then the role will simply install Mailpit and stop, leaving it to you to start and stop the application.

This role works fine in Docker, however [for `ce-dev` you might consider using the Mailpit container instead](https://mailpit.axllent.org/docs/install/docker/).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
mailpit:
  script_install_path: "/home/{{ user_provision.username }}"
  https: true
  create_cert: true
  service: true
  database_directory: "/home/{{ user_provision.username }}/mailpit" # must be readable and writeable by the executing user
  database_filename: mailpit.db
  smtp_listen: 0.0.0.0:1025
  web_ui_listen: 0.0.0.0:8025
  web_ui_webroot: /
  web_ui_authfile_src: "" # path to your base auth passwords file on the Ansible controller - see https://mailpit.axllent.org/docs/configuration/http-authentication/
  web_ui_authfile_dest: "" # path where you want to place your passwords file on the target - leave empty for no basic auth
  web_ui_ssl_cert: "/etc/ssl/selfsigned/{{ _domain_name }}.cert"
  web_ui_ssl_key: "/etc/ssl/selfsigned/{{ _domain_name }}.key"
  # LetsEncrypt example paths
  #web_ui_ssl_cert: "/etc/letsencrypt/live/{{ _domain_name }}/fullchain.pem"
  #web_ui_ssl_key: "/etc/letsencrypt/live/{{ _domain_name }}/privkey.pem"
  additional_options: "" # runtime custom options - see https://mailpit.axllent.org/docs/configuration/runtime-options/
  # only used if https: false, otherwise must run as root
  user: "{{ user_provision.username }}"
  group: "{{ user_provision.username }}"
  # @see the 'ssl' role - defaults to using LetsEncrypt
  ssl:
    replace_existing: false
    domains:
      - "{{ _domain_name }}"
    handling: selfsigned
    # example LetsEncrypt config
    #handling: letsencrypt
    #http_01_port: 80
    #autorenew: true
    #email: sysadm@codeenigma.com
    #services:
    #  - nginx
    #web_server: standalone
    #certbot_register_command: "/usr/bin/certbot certonly --agree-tos --preferred-challenges http -n"
    #certbot_renew_command: "/usr/bin/certbot certonly --agree-tos --force-renew"
    #reload_command: restart
    #reload:
    #  - mailpit
    #on_calendar: "Mon *-*-* 04:00:00"

```

<!--ENDROLEVARS-->
