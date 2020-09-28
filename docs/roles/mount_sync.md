# cmount sync

Syncronize some "mounted" filesystems with the local one. Typically used for EFS/NFS mounts on autoscale clusters.
It will:

- perform an initial rsync using a cloud-init script
- use Unison to perform regular checks (mostly to catch edge-cases where an instance would be spinned up during the middle of a deployment)
  <!--TOC-->
  <!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
mount_sync:
  # A list of target/destination definitions.
  sync_pairs:
    - src: /my/path/to/sync
      dest: /another/path/to/sync
      minute: "*/10"
      name: example
      owner: root
      group: root

```

<!--ENDROLEVARS-->
