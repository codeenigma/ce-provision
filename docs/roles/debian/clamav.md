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
  # wrapper scripts for clamav
  scripts:
    - location: /usr/local/clamav/script
      name: clamscan_daily
      exclude_directories:
        - /sys/
      scan_location: /
      log_name: clamav_daily.log
  # scheduled scans, set to an empty dictionary for no timers
  timers:
    clamscan_daily:
      timer_command: /usr/local/clamav/script/clamscan_daily # path to clamscan wrapper script, ensure it is defined in clamav.scripts
      timer_OnCalendar: "*-*-* 02:30:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events
  server_name: "{{ inventory_hostname }}" # for identification via email, defaults to Ansible inventory name.
  log_location: /var/log/clamav
  send_mail: false # Important: will not send any emails by default.
  send_on_fail: true # Only sends emails on scan failure, will not email for successful scans.
  report_recipient_email: mail@example.com
  report_sender_email: admin@server.example.com
  install_clamdscan: false # flag to install additional 'clamdscan' package

```

<!--ENDROLEVARS-->
