# ClamAV
This role provides a wrapper for [Jeff Geerling's Ansible role for ClamAV](https://github.com/geerlingguy/ansible-role-clamav).

This role optionally provides systemd timers for routine scanning if you are not running ClamAV in daemon mode.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
clamav:
  create_timer: false
  server_name: "{{ inventory_hostname }}" # for identification via email, defaults to Ansible inventory name.
  on_calendar: "*-*-* 02:30:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events
  scripts_location: /usr/local/clamav/script
  log_location: /var/log/clamav
  log_name: clamav.log
  send_mail: false # Important: will not send any emails by default.
  send_on_fail: true # Only sends emails on scan failure, will not email for successful scans.
  report_recipient_email: mail@example.com
  report_sender_email: admin@server.example.com
  scan_location: /
  exclude_directories:
    - /sys/
  install_clamdscan: false # flag to install additional 'clamdscan' package

```

<!--ENDROLEVARS-->
