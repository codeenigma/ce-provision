# OpenVPN
This role installs [the `openvpn-install.sh`` bash script from GitHub](https://github.com/angristan/openvpn-install) and optionally runs it in headless mode.

## PAM authentication
There are two options here, one is simple PAM authentication against Linux users, the other is PAM authentication with LDAP. If you want to provide a custom PAM configuration you should set `openvpn.pam.enabled` to `true` and create your own template to override the `openvpn.pam.j2` template provided. This file is placed in `/etc/pam.d/openvpn` and loaded by the OpenVPN authentication module to perform authorisation checks.

The LDAP integration ships with a default configuration for PAM which, as above, can be overridden. It assumes the use of [our `pam_ldap` role](https://github.com/codeenigma/ce-provision/tree/2.x/roles/debian/pam_ldap) for the LDAP variables and defaults to those values, but they can be set explicitly if required.

## Hardcoded values
At the moment we do not support headless customisation of encryption settings. This seems possible [by setting the right variables](https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L392-L401) and we'll add it later if we can. The defaults are sane, but please note the default cipher is `AES-128-GCM`. We have allowed for finding and replacing this value as part of our role.

[The client config directory is set to `/etc/openvpn/ccd`.](https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L900C19-L900C35)

<!--ROLEVARS-->
<!--ENDROLEVARS-->
