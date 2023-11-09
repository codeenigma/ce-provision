# ClamAV
This role provides a wrapper for [Jeff Geerling's Ansible role for ClamAV](https://github.com/geerlingguy/ansible-role-clamav).

This role optionally provides cron scripts for routine scanning if you are not running ClamAV in daemon mode.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
clamav:
  provide_cron: false
  server_name: "{{ inventory_hostname }}" # for identification via email, defaults to Ansible inventory name.
  cron_minute: "0" # Runs daily at midnight by default.
  cron_hour: "0"
  # cron_day: "*"
  # cron_weekday: "0" # 0-6 for Sunday-Saturday
  scripts_location: /usr/local/clamav/script
  log_location: /usr/local/clamav/log
  send_mail: false # Important: will not send any emails by default.
  send_on_fail: true # Only sends emails on scan failure, will not email for successful scans.
  report_recipient_email: mail@example.com
  report_sender_email: admin@server.example.com
  scan_location: /
  exclude_directories:
    - /sys/

```

<!--ENDROLEVARS-->
