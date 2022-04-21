# SSL
Manages SSL certificates.

<!--TOC-->
<!--ENDTOC-->

If you are using LetsEncrypt for handling it assume `standalone` mode. If you want to do DNS validation, please do not use this role at this time. There are a few pre-requisites for `standalone` mode to work:

* You must have firewalls open to allow traffic to ports 80 and/or 443, regardless of your configuration
* LetsEncrypt's certbot application will try to use port 80, if this will not be possible you can either:
  * change `ssl.http_01_port` to another available port for `certbot` to listen on; or
  * provide a list of services to stop prior to creating/renewing LE certificates, so port 80 is available
* If you change `ssl.http_01_port` *something* still needs to proxy traffic to the port you chose locally

On the final point, our `nginx` role supports this automatically. In the `_common` config, which is included in all vhosts, you will find this block:

```
{% if ssl is defined and ssl.handling == 'letsencrypt' and ssl.http_01_port != 80 %}
# Proxy for certbot (LetsEncrypt)
location /.well-known/acme-challenge/ {
    proxy_pass http://localhost:{{ ssl.http_01_port }}$request_uri;
}
{% endif %}
```

So if you are using LetsEncrypt handling, you set `ssl.http_01_port` to something other than `80` and you are using our `nginx` role, it should take care of the proxying.

If you are using Nginx or Apache you can set the `ssl.web_server` to either `nginx` or `apache` to have the necessary plugin installed for `certbot` to do automatic handling of LetsEncrypt requests. Be aware, it does this by temporarily altering your web server config and reloading - use this option at your own risk. This is *not* intended to be used with but *instead of* `ssl.http_01_port`.

<!--ROLEVARS-->
## Default variables
```yaml
---
ssl:
  domain: www.example.com
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
  # For "letsencrypt" handling.
  email: admin@example.com
  # For "letsencrypt" handling, a list of service to stop while creating the certificate.
  # This is because we need port 80 to be free.
  # eg;
  # services:
  #   - nginx
  services: []
############ Facts
# ssl_facts
# A dict of domain names with key/cert destination paths.
# { }

```

<!--ENDROLEVARS-->
