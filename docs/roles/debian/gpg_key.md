# GPG Key
Generates a passwordless GPG key for a given user or users.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
gpg_key_servers:
  - hkps://pgp.mit.edu
  - hkps://keys.openpgp.org
gpg_key:
  - username: example # Must exist already on the server.
    publish: false # Whether to publish to HKS public servers.
    key_type: "RSA"
    key_length: 4096
    email: example@example.com
    expire: 0

```

<!--ENDROLEVARS-->
