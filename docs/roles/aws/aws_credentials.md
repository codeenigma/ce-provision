# Amazon credentials
Simple role generating credentials "profiles" in users $HOME/.aws/credentials.

<!--TOC-->
<!--ENDTOC-->


<!--ROLEVARS-->
## Default variables
```yaml
---
aws_credentials:
  - user: ce-dev
    profiles:
      - name: profile1
        access_key_id: XXX
        secret_access_key: XXXX
      - name: example
        access_key_id: XXX
        secret_access_key: XXXX
  - user: root
    profiles:
      - name: another
        access_key_id: XXX
        secret_access_key: XXXX
      - name: profile2
        access_key_id: XXX
        secret_access_key: XXXX

```

<!--ENDROLEVARS-->
