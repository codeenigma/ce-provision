# APT extras
Provides a wrapper for managing packages through apt. Will replace apt_extra_packages soon.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
apt_extras:
  apt_extra_packages: []
  apt_unattended_upgrades: true
  # unattended-upgrades template vars.
  # booleans must be strings to avoid Jinja2 interpretting.
  apt_unattended_upgrade_origins:
    - "origin=Debian,codename=${distro_codename},label=Debian"
    - "origin=Debian,codename=${distro_codename},label=Debian-Security"
  apt_unattended_blocked_packages: [] # list of package patterns to not upgrade
  apt_unattended_upgrade_mail: "sysadmins@example.com" # email to send upgrade notifications to
  apt_unattended_upgrade_mail_on_error: "true" # send mail on error only
  apt_remove_unused_dependencies: "false"
  apt_automatic_reboot: "false"
  apt_automatic_reboot_with_users: "false" # reboot even if users are logged in
  apt_automatic_reboot_time: "02:00"  
  apt_enable_syslog: "false" # make apt log upgrades to syslog as well as apt history

```

<!--ENDROLEVARS-->
