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
  schedule: "0 0 * * *"

```

<!--ENDROLEVARS-->
