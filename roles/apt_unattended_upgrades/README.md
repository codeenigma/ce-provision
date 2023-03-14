# APT Unattended Upgrades
Provides a wrapper for managing the APT unattended-upgrades configuration.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_apt_unattended_upgrades_default_origins:
    - "origin=Debian,codename=${distro_codename},label=Debian"
    - "origin=Debian,codename=${distro_codename},label=Debian-Security"

apt_unattended_upgrades:
  enable: true
  # unattended-upgrades template vars.
  # booleans must be strings to avoid Jinja2 interpretting.
  origins: "{{ _apt_unattended_upgrades_default_origins }}"
  blocked_packages: [] # list of package patterns to not upgrade
  mail: "sysadmins@example.com" # email to send upgrade notifications to
  mail_on_error: "true" # send mail on error only
  remove_unused_dependencies: "false"
  automatic_reboot: "false"
  automatic_reboot_with_users: "false" # reboot even if users are logged in
  automatic_reboot_time: "02:00"  
  enable_syslog: "false" # make apt log upgrades to syslog as well as apt history

```

<!--ENDROLEVARS-->
