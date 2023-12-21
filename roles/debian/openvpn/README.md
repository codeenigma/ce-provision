# OpenVPN
This role installs [the `openvpn-install.sh`` bash script from GitHub](https://github.com/angristan/openvpn-install) and optionally runs it in headless mode.

## Hardcoded values
At the moment we do not support headless customisation of encryption settings. This seems possible [by setting the right variables](https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L392-L401) and we'll add it later if we can. The defaults are sane, but please note the default cipher is `AES-128-GCM`. We have allowed for finding and replacing this value as part of our role.

[The client config directory is set to `/etc/openvpn/ccd`.](https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L900C19-L900C35)

<!--ROLEVARS-->
<!--ENDROLEVARS-->
