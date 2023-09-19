# EFS client
Mounts EFS volume(s) to specific mount point(s).

The [`efs_info` role for Ansible](https://docs.ansible.com/ansible/latest/collections/community/aws/efs_info_module.html) searches based on the `creation_token` attribute of a file system. This is usually the same as `name` **but not always!**

If your EFS volume was not created by Ansible or via the console but was created automatically, for example by setting up replication to another region, no matter what you set the human-readable `name` to the `creation_token` will remain a dynamically generated value, such as `destination-5e6b763c-0f8b-4e90-9392-8c83b2453553`. It is the `creation_token` value that matters, **not** `name`, so in this case your mount will need to look like this:

```yaml
  mounts:
    - path: /mnt/shared
      src: destination-5e6b763c-0f8b-4e90-9392-8c83b2453553
      opts: _netdev
      state: present
      owner: root
      group: root
```

You cannot retrieve the `creation_token` from the console, you need to use the API, for example:

```
aws efs describe-file-systems --profile myaccount --region eu-west-1
```

In the output of listed file systems, for each one you will find an entry like this:

```
    "CreationToken": "destination-fba829fc-3680-4b7d-be6a-147d02c357b3"
```

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_mount_opts: "_netdev,noresvport" # _netdev tells OS to wait for network before attempting to mount
_mount_state: present
aws_efs_client:
  aws_profile: "{{ _aws_profile }}"
  region: "{{ _aws_region }}"
  version: 1.26.2 # Version of AWS EFS utils to use.
  # See https://docs.ansible.com/ansible/latest/modules/mount_module.html
  mounts:
    - path: /mnt/shared
      src: example-efs # This is the EFS "creation_token" which is not always "name" - read the role docs carefully!
      opts: "{{ _mount_opts }}"
      state: "{{ _mount_state }}"
      owner: root
      group: root

```

<!--ENDROLEVARS-->
