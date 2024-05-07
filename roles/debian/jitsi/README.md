# Jitsi

Installs the Jitsi Meet video conferencing product. See https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-quickstart

<!--ROLEVARS-->
## Default variables
```yaml
---
jitsi:
  apt_signed_by: https://download.jitsi.org/jitsi-key.gpg.key
  server_name: "{{ _domain_name }}"
  email: admin@example.com
```

<!--ENDROLEVARS-->
