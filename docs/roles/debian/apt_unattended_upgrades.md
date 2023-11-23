# APT Unattended Upgrades
Provides a wrapper for managing the APT `unattended-upgrades` configuration.

<!--TOC-->
<!--ENDTOC-->

## Overview
Since Debian 9 the `unattended-upgrades` package and service have been enabled by default. This role allows you to configure that by replacing the standard config with a templated copy. By default we enable `unattended-upgrades` with standard Debian updates and Debian security patches, plus emailing of results in the case of an upgrade error.

## General settings
You should make sure you set `apt_unattended_upgrades.mail` in your implementation to get emails from your server when the service runs.

If you do not want to enable the `unattended-upgrades` service, set `enable: false`. *However*, please note your Debian server will probably have it installed as standard and the role will not *remove* `unattended-upgrades` if it is already installed, you will need to do that manually.

Please review the `50unattended-upgrades.j2` file that ships with this role for inline documentation for all options. You can also see what options are supported by the role by reviewing where variables are inserted into that template.

## Adding origins and blocked packages
Please review the `50unattended-upgrades.j2` file that ships with this role for detailed inline documentation on how to use `apt_unattended_upgrades.origins` and `apt_unattended_upgrades.blocked_packages`.

The best way to handle *adding* origins to a server is to do something like this in your variables:

```yaml
apt_unattended_upgrades:
  origins: "{{ _apt_unattended_upgrades_default_origins + [ "origin=MyRepo,codename=bullseye", "origin=MyOtherRepo,codename=bullseye,label=stable" ] }}"
```

Alternatively you can simply replace the list like so, however this will *remove* the Debian defaults unless you re-add them to your list:

```yaml
apt_unattended_upgrades:
  origins:
    - "origin=MyRepo,codename=bullseye"
    - "origin=MyOtherRepo,codename=bullseye,label=stable"
```

To find out what the origin string should look like, you can read the top of the InRelease files to see the components. These files are typically found in `/var/lib/apt/lists/`.

There are no `blocked_packages` by default, but you can define a list of names or patterns to skip unattended upgrades.

```yaml
apt_unattended_upgrades:
  blocked_packages:
    - "php*"
```

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
