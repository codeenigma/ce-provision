# SSL
Manages SSL certificates on servers. See the `aws/aws_acm` role for SSL handling in AWS services.

<!--TOC-->
<!--ENDTOC-->

## LetsEncrypt
If you are using LetsEncrypt for handling it assumes `standalone` mode. If you want to do DNS validation, please do not use this role at this time. There are a few pre-requisites for `standalone` mode to work:

* You must have firewalls open to allow traffic to ports 80 and/or 443, regardless of your configuration
* LetsEncrypt's certbot application will try to use port 80, if this will not be possible you can either:
  * change `ssl.http_01_port` to another available port for `certbot` to listen on; or
  * provide a list of services to stop prior to creating/renewing LE certificates, so port 80 is available
* If you change `ssl.http_01_port` *something* still needs to proxy traffic to the port you chose locally

On the final point, our `nginx` role supports this automatically. In the `vhost` config you will find this block:

```
# Proxy for certbot (LetsEncrypt)
location /.well-known/acme-challenge/ {
    proxy_pass http://localhost:{{ ssl.http_01_port }}$request_uri;
}
```

If you are using LetsEncrypt handling combined with our `nginx` role and you set `ssl.http_01_port` then it should take care of the proxying, for example:

```yaml
nginx:
  domains:
    - # other domain variables here
      ssl:
        domains:
          - "{{ _domain_name }}"
        handling: letsencrypt
        http_01_port: 54321
        autorenew: true
        email: administrator@example.com
        services: []
        certbot_register_command: "/usr/bin/certbot certonly --standalone --agree-tos --preferred-challenges http -n"
        certbot_renew_command: "/usr/bin/certbot certonly --standalone --agree-tos --force-renew"
```

You need to include *all* variables required by the `letsencrypt` SSL handler because defaults will not load from the `ssl` role in this context.

If you are using Nginx or Apache you can set the `ssl.web_server` for each domain to either `nginx` or `apache` to have the necessary plugin installed for `certbot` to do automatic handling of LetsEncrypt requests. Be aware, it does this by temporarily altering your web server config and reloading - use this option at your own risk. This is *not* intended to be used with but *instead of* `ssl.http_01_port`.

<!--ROLEVARS-->
## Default variables
```yaml
---
ssl:
  domains: # you can provide multiple domains if you need
    - www.example.com
  # Handling for certs, can be one of:
  # - letsencrypt: Generates individual LetsEncrypt certificate using the HTTP challenge
  # - selfsigned: Generates self-signed certificates
  # - manual: Use provided certificates. Requires key/cert.
  # - unmanaged: Doesn't do anything. Note that for consistency reasons, key/cert paths are still needed.
  handling: selfsigned
  # For "manual" handling, this is the content of the certificate.
  # If you want to to provide a file instead, use lookup('file', '/path/on/the/controller') as the value.
  # For "unmanaged" handling, this must be set to the absolute path on the target.
  # For "manual" handling you can optionally include a ca_cert variable if your CA cert must be a separate file.
  cert: |
    -----BEGIN CERTIFICATE-----
    f34XAAVI+R04k0TLUcfeU4/8QYQ3qY1aDvwonT3PE6VYRAGMGJflz//133EquNUR
    oMz3CA==
    -----END CERTIFICATE-----
  # For "manual" handling, this is the content of the key.
  # For "unmanaged" handling, this must be set to the absolute path on the target.
  key: |
    -----BEGIN PRIVATE KEY-----
    79RG06iurGJEorFopyQesKwix1h6aBYXpM8yZ0IPR0leeeipBtYHIwbPHEYRJiFn
    6XoQQlb5mYuLKCzAZws9uceeVH+z
    -----END PRIVATE KEY-----
  # Set this to true to have Ansible replace the existing certificate.
  replace_existing: false

  # For "letsencrypt" handling.
  email: admin@example.com
  certbot_register_command: "certonly --agree-tos --preferred-challenges http -n" # root of the command to register a new cert
  http_01_port: 80 # you can set a non-standard port to listen on, but certbot still needs port 80 - see https://letsencrypt.org/docs/challenge-types/#http-01-challenge
  # For "letsencrypt" auto renewal
  autorenew: false # set to true to create a systemd timer to renew LE certs
  certbot_renew_command: "certonly --agree-tos --force-renew" # root of the command used in the systemd timer
  # See systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events
  #on_calendar: "Mon *-*-* 04:00:00"
  web_server: standalone # values are standalone, nginx or apache - warning, nginx and apache will attempt to manipulate your vhosts!

  # For "letsencrypt" handling, a list of service to stop while creating the certificate.
  # This is because we need port 80 to be free.
  # List of services to be stopped during renewal, e.g.
  #services:
  #  - nginx
  services: []
  # When certificates get renewed on a schedule you also need to reload any dependent services, such as your web server.
  # List of services to reload:
  reload: []
  reload_command: restart # use 'reload' if you do not want to restart, but in most cases a full restart is required to load a new cert.
  # Location of Certbot installation and components for LetsEncrypt.
  # These are usually set in the _init role using _venv_path, _venv_command and _venv_install_username but can be overridden.
  #letsencrypt:
  #  venv_path: "/home/{{ user_provision.username }}/certbot"
  #  venv_command: /usr/bin/python3 -m venv
  #  venv_install_username: "{{ user_provision.username }}"

############ Facts
# ssl_facts
# A dict of domain names with key/cert destination paths.
# { }

```

<!--ENDROLEVARS-->
