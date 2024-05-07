# MySQL Server - Oracle Community Edition
<!--TOC-->
<!--ENDTOC-->

Installs MySQL Server 8.0 by default.

<!--ROLEVARS-->
## Default variables
```yaml
---
mysql_server:
<<<<<<< HEAD
  apt_origin: "origin=repo.mysql.com/apt,codename=${distro_codename},label=mysql" # used by apt_unattended_upgrades
  apt_signed_by: https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
  apt_repo_version: mysql-8.0
  long_query_time: 4
=======
  long_query_time: 4
  apt_signed_by: https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
  apt_repo_version: mysql-8.0
>>>>>>> required_paramater_for_gp3_storage_type

```

<!--ENDROLEVARS-->
