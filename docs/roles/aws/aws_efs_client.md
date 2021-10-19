# EFS client
Mounts EFS volume(s) to specific mount point(s).
It uses the "Name" tag for a given volume to retrieve the volume path.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_efs_client:
  aws_profile: "{{ _aws_profile }}"
  region: eu-west-3
  version: 1.26.2 # Version of AWS EFS utils to use.
  # See https://docs.ansible.com/ansible/latest/modules/mount_module.html
  mounts:
    - path: /mnt/shared
      src: example-efs # This will be translated from the "name"
      opts: _netdev # _netdev tells OS to wait for network before attempting to mount
      state: present
      owner: root
      group: root

```

<!--ENDROLEVARS-->
