# Apparmor
This role installs the `apparmor` application for additional security. Documentation for Debian is here:
* https://wiki.debian.org/AppArmor/HowToUse

The only additional feature of this role, aside from installing the package, is to create custom `apparmor` profiles. To create profiles you can provide a list with the variable `apparmor.custom_profiles`. Each item should have two elements, `filename` and `contents`. It is vitally important that `filename` matches the path to the binary you wish to provide a profile for. In the example commented out in the defaults you will note the filename is `usr.sbin.clamd` which means it applies to the binary at `/usr/sbin/clamd`, which is the location of the ClamAV daemon.

The `contents` part is literally what will be placed in the file when the template is copied accross. In the case of our example, `/home/deploy/** r,`, this means allow the binary at `/usr/sbin/clamd` to read anything in the `/home/deploy` directory - our typical application location - and do not block that activity. In other words, do not impede virus scanning.

If needed you can utilise Ansible's inheritance model to create your own, more complex `custom_profile.j2` template file with your playbook and provide additional variables per item. Essentially what ships with the role is a simple example that is fit for most purposes.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
apparmor:
  custom_profiles: []
    # example
    #- filename: usr.sbin.clamd
    #  contents: |
    #    /home/deploy/** r,
    #

```

<!--ENDROLEVARS-->
