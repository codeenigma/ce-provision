# Duplicity
Role to install and configure [the Duplicity backup engine](https://duplicity.us/) for off site backups in Linux.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
duplicity:
  backend: s3 # currently also support b2 for Backblaze
  access_key_id: "somekey"
  secret_access_key: "somesecret"
  backend_url: "s3-eu-west-1.amazonaws.com"
  s3_options: "--s3-european-buckets --s3-use-glacier-ir" # see the --s3 options in the documentation - https://duplicity.us/stable/duplicity.1.html#options
  bucketname: "somebucket"
  dirs:
    - name: "/boot"
      rules: []
    - name: "/etc"
      rules: []
    - name: "/opt"
      rules: []
    - name: "/var"
      rules:
        - "+ /var/log/syslog*"
        - "- /var"
  exclude_other_filesystems: false
  full_backup_frequency: "3M"
  gpg_passphrase: "{{ lookup('password', _ce_provision_data_dir + '/' + inventory_hostname + '/duplicity-gpg-passphrase chars=ascii_letters,digits length=64') }}"
  install_dir: "/opt/duplicity"
  mail_recipient: "foo@bar.com"
  retention_period: "12M"
  # systemd timer settings
  create_timer: true # sometimes you might want to trigger duplicity some other way than a systemd timer
  on_calendar: "*-*-* 03:30:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->