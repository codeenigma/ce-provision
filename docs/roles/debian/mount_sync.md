# Mount sync

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
  deploy_dir: "/home/{{ user_deploy.username }}/deploy"

  # Supports either tarball deployments or SquashFS deployments

  # Supply a list of paths to files to be untarred
  tarballs: []
  #  - /path/to/initial/seed.tar

  # Supply list of dicts defining sqsh files to be mounted on boot
  # project_name and build_type must match the corresponding ce-deploy variables.
  squashed_fs: []
  #  - project_name: myproject
  #    build_type: dev
  #    path: /path/to/initial/system.sqsh

  # Only used by SquashFS, base location to copy the image file to.
  build_dir: "/home/{{ user_deploy.username }}/builds"

```

<!--ENDROLEVARS-->
