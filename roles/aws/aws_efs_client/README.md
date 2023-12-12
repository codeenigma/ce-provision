# EFS client
Mounts EFS volume(s) to specific mount point(s).

## How the client package is created
Because AWS do not ship a .deb file but [provide build instructions instead](https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html), we use GitHub Actions in a dedicated repository to build the `efs-utils` package. By default this role will fetch a .deb package from the Code Enigma repository, here:
* https://github.com/codeenigma/aws-efs-utils-deb-builder/tags

If you wish to provide your own package, use `aws_efs_client.deb_url` to provide a full URL to a downloadable .deb file containing AWS EFS utils.

## Using the correct `src` value
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
  version: 1.35.0 # version of AWS EFS utils to use
  build_suffix: "-1_all" # sometimes there is a suffix appended to the package name, e.g. `amazon-efs-utils-1.35.0-1_all.deb`
  deb_url: "" # provide an alternative location for the .deb package
  # See https://docs.ansible.com/ansible/latest/modules/mount_module.html
  mounts:
    - path: /mnt/shared
      src: example-efs # this is the EFS "creation_token" which is not always "name" - read the role docs carefully!
      opts: "{{ _mount_opts }}"
      state: "{{ _mount_state }}"
      owner: root
      group: root

```

<!--ENDROLEVARS-->
