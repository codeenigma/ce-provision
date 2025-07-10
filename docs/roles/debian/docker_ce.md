# Docker CE
Installs Docker Engine community edition and related tools. Will install the Docker Compose plugin by default.

<!--ROLEVARS-->
## Default variables
```yaml
---
docker_ce:
  apt_origin: "origin=download.docker.com/linux,codename=${distro_codename},label=docker-ce" # used by apt_unattended_upgrades
  apt_signed_by: https://download.docker.com/linux/debian/gpg
  docker_compose: true

```

<!--ENDROLEVARS-->
