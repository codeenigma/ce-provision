# Postfix
Installs and configures Postfix for sending mail. Mail sending is disabled by default using transport maps.

Full TLS SMTP support is optional by enabling SSL.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---

postfix:
  hostname: "{{ ansible_fqdn }}" # if you set this to something else you may have to create PTR records to avoid bouncing
  dest_hosts: "mail.host1.com,mail.host2.com"
  disable_vrfy: "no" # leave as 'no' for Postfix config, not a YAML boolean
  interfaces: all
  # ce_dev_delivery_mode is only used when is_local == true, which means you're probably using ce-dev locally. Valid modes are host, local and discard.
  ce_dev_delivery_mode: "host"
  message_size: 10240000
  networks: "[::1]/128 [::ffff:127.0.0.0]/104 127.0.0.0/8"
  protocols: all
  relayhost: ""
  transport_maps:
    - "* discard :"
  use_dkim: false
  # AWS SES config - to authenticate with an IAM user see https://docs.aws.amazon.com/ses/latest/dg/smtp-credentials.html
  use_ses: false
  ses_creds: ACCESSKEY:sEcreTkEY # encrypt with SOPS - you must use SMTP credentials, *not* IAM credentials
  # Forwarding config
  forward: false
  forward_domains:
    - another.com
    - lalala.com
  forward_from: admin@example.com
  forward_to: admin@example.com
  aliases: []
    #- user: root
    #  alias: admin@example.com
  # Basic optional SSL handling - does not currently use the SSL role, as it is likely being handled elsewhere
  ssl:
    enabled: false
    smtp_tls_cert_file: "" # full path to certificate, e.g. /etc/letsencrypt/live/acme.com/fullchain.pem
    smtp_tls_key_file: "" # full path to key, e.g. /etc/letsencrypt/live/acme.com/privkey.pem
    smtp_tls_CApath: /etc/ssl/certs
    smtp_tls_CAfile: /etc/ssl/certs/ca-certificates.crt

```

<!--ENDROLEVARS-->
