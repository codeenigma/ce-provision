# PAM LinOTP
Authentication module for integrating PAM logins with LinOTP second factor of authentication. We package this from source ourselves, as [LinOTP provide the source code on GitHub](https://github.com/LinOTP/linotp-auth-pam) but no APT package.

<!--ROLEVARS-->
## Default variables
```yaml
---
pam_linotp:
  apt_signed_by: https://packages.codeenigma.net/debian/codeenigma.pub
  # LinOTP endpoint.
  endpoint: ""
  # PAM policies.
  su: true
  sudo: true
  ssh: true

```

<!--ENDROLEVARS-->
