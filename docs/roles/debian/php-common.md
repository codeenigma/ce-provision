# PHP common components

Installs and configures PHP core and required components.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
php:
  version:
    - 8.1 # see https://www.php.net/supported-versions.php
<<<<<<< HEAD
  apt_signed_by: https://packages.sury.org/php/apt.gpg
=======
>>>>>>> required_paramater_for_gp3_storage_type
  apt_origin: "origin=deb.sury.org,codename=${distro_codename}" # used by apt_unattended_upgrades

```

<!--ENDROLEVARS-->
