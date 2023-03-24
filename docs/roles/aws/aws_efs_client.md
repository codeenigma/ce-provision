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
  region: "{{ _aws_region }}"
  version: 1.26.2 # Version of AWS EFS utils to use.
  # See https://docs.ansible.com/ansible/latest/modules/mount_module.html
  mounts:
    - path: /mnt/shared
      src: example-efs # Can be the mount "name" or the "id" - if you use "id" set `search_by_id: true`
      opts: _netdev # _netdev tells OS to wait for network before attempting to mount
      state: present
      owner: root
      group: root
      search_by_id: false # in some circumstances name-based lookup will not work

```

<!--ENDROLEVARS-->
