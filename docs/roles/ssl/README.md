# SSL
Manages SSL certificates.
<!--TOC-->
<!--ENDTOC-->


<!--ROLEVARS-->
## Default variables
```yaml
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
