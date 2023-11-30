# NodeJS

Installs NodeJS from official repos.

<!--ROLEVARS-->
## Default variables
```yaml
---
nodejs:
  # Used by apt_unattended_upgrades
  apt_origin_nodejs: "origin=Node Source,codename=${distro_codename},label=Node Source" # nodejs repo
  apt_origin_yarn: "origin=yarn,codename=stable,label=yarn-stable" # yarn repo
  version: 18.x # LTS - see https://nodejs.dev/en/about/releases/
  npm_packages: []
  #npm_packages:
  #  - name: coffee-script # required
  #    version: "1.6.1"
  #    path: /path/to/node/app # omit to install globally

```

<!--ENDROLEVARS-->
