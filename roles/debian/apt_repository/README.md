# APT Repository
Role for handling the installation and management of APT repos. Uses the DEB822 format.

The variables `uris`, `suites` and `components` combine to build an APT repository request, for example these are the variables for the MySQL 8.0 repository:

```yaml
  uris:
    - http://repo.mysql.com/apt/debian/
  suites:
    - "{{ ansible_distribution_release }}"
  components:
    - mysql-8.0
```

This example results in APT referring to the following URI on a Debian 11 (bullseye) system: https://repo.mysql.com/apt/debian/dists/bullseye/mysql-8.0/

## Installing with key fingerprints
This role does not currently support importing keys from a key server. Since key servers are deprecated, it likely never will. You should either provide an ASCII armored key as a block of text or the URL of a GPG or ASCII armored key.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
apt_repository:
  legacy_repo: "" # optionally provide repo string of old list file to clean up, we are creating a new DEB822 format source file
  name: example
  types:
    - deb
  uris:
    - https://example.com/apt
  #signed_by: https://example.com/apt-key.asc # either the path to the key or the key contents
  #suites:
  #  - "{{ ansible_distribution_release }}"
  components:
    - main
  state: present
  enabled: true
  key_refresh_timer_OnCalendar: "Mon *-*-* 00:00:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->
