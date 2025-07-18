# NodeJS

Installs NodeJS from official repos.

<!--ROLEVARS-->
## Default variables
```yaml
---
nodejs:
  # Used by apt_unattended_upgrades
  apt_origin_nodejs: "origin=. nodistro,codename=nodistro,label=. nodistro" # nodejs repo
  apt_origin_nodejs_old: "origin=Node Source,codename=${distro_codename},label=Node Source" # nodejs repo
  apt_signed_by_nodejs: https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key
  apt_origin_yarn: "origin=yarn,codename=stable,label=yarn-stable" # yarn repo
  apt_signed_by_yarn: https://dl.yarnpkg.com/debian/pubkey.gpg
  version: 22.x # LTS - see https://nodejs.dev/en/about/releases/
  start_corepack: false # corepack is shipped with nodejs and enables a core set of packages
  npm_packages: []
  #npm_packages:
  #  - name: coffee-script # required
  #    version: "1.6.1"
  #    path: /path/to/node/app # omit to install globally

```

<!--ENDROLEVARS-->
