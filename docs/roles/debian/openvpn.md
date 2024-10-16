# OpenVPN
This role installs [the `openvpn-install.sh`` bash script from GitHub](https://github.com/angristan/openvpn-install) and optionally runs it in headless mode.

## Server address
This will be detected automatically as the IP address of the server. If the server is configured with only internal addressing then the script will attempt to look up the public IP. To specify a value use `openvpn.nat_endpoint`.

## PAM authentication
There are two options here, one is simple PAM authentication against Linux users, the other is PAM authentication with LDAP. If you want to provide a custom PAM configuration you should set `openvpn.pam.enabled` to `true` and create your own template to override the `openvpn.pam.j2` template provided. This file is placed in `/etc/pam.d/openvpn` and loaded by the OpenVPN authentication module to perform authorisation checks.

The LDAP integration ships with a default configuration for PAM which, as above, can be overridden. It assumes the use of [our `pam_ldap` role](https://github.com/codeenigma/ce-provision/tree/2.x/roles/debian/pam_ldap) for the LDAP variables and defaults to those values, but they can be set explicitly if required.

## Hardcoded values
At the moment we do not support headless customisation of encryption settings. This seems possible [by setting the right variables](https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L392-L401) and we'll add it later if we can. The defaults are sane, but please note the default cipher is `AES-128-GCM`. We have allowed for finding and replacing this value as part of our role.

[The client config directory is set to `/etc/openvpn/ccd`.](https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L900C19-L900C35)

<!--ROLEVARS-->
## Default variables
```yaml
---
openvpn:
  script_install_path: "/home/{{ user_provision.username }}"
  fqdn: "" # fully qualified domain name of VPN server for use in client config, uses IP address if empty - only works with port_choice: "1"
  auto_install: true
  # post install server config tweaks
  ipv4_settings: "" # defaults to `10.8.0.0 255.255.255.0` - example, to use 192.168.140.0/24 set "192.168.140.0 255.255.255.0"
  cipher: "" # defaults to AES-128-GCM, see https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L404-L410
  allow_floating_client_ip: true # allow for ISP address change with DHCP (option float)
  multiple_connections: false # set to true to enable multiple VPN connections (option duplicate-cn)
  push_routes_ipv4: [] # list of VPN push routes for ipv4 networks
    # Examples:
    # - "192.168.1.0 255.255.255.0" # push range 192.168.1.0/24, format = "IP-address/range netmask"
    # - "1.2.3.4 255.255.255.255" # push specific IP 1.2.3.4
    # - "www.google-analytics.com 255.255.255.255" # push any IP resolving to www.google-analytics.com, must set allow_pull_fqdn to true
  push_routes_ipv6: [] # list of VPN push routes for ipv6 networks - ipv6_support must be "y"
  # PAM and LDAP authentication
  pam:
    enabled: false # relies on `openvpn-plugin-auth-pam.so` which is bundled with OpenVPN server for Debian
    module_path: /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so # use `dpkg -L openvpn | grep '\bpam\b'` to discover the path
    config_template: openvpn.pam.j2 # allow override of PAM config template
  ldap:
    enabled: false # if true we assume the pam_ldap role is also being used on this server
    config_template: openvpn.pam.ldap.j2 # allow override of PAM config template for LDAP
    endpoints: "{{ pam_ldap.endpoints | default('[]') }}"
    lookup_base: "{{ pam_ldap.lookup_base | default('') }}"
    lookup_filter: "|(objectClass=inetOrgPerson)" # LDAP filter to apply to lookups
    login_attribute: uid # the LDAP attribute to check the OpenVPN username against
    group_base: "" # e.g. ou=Groups,dc=example,dc=com
    group_dn: "" # restrict to specific group, e.g. cn=admins,ou=Groups,dc=example,dc=com
    group_attribute: memberUid # the LDAP group attribute to check the OpenVPN username against
    ssl_certificate: "{{ pam_ldap.ssl_certificate | default('') }}"
    ssl_certificate_check: "{{ pam_ldap.ssl_certificate_check | default(true) }}"
  # post install client config tweaks
  tls_cipher: "" # defaults to TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256, see https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L486-L518
  allow_pull_fqdn: true # this must be enabled if you want to push FQDNs (option allow-pull-fqdn)
  auth_user_pass: false # enforce authorisation with a username and password - desired for LDAP authentication
  # headless script variables
  approve_ip: "y"
  ipv6_support: "n"
  port_choice: "1" # 1 = use default 1194, 3 means use a random port
  protocol_choice: "1" # 1 = udp, 2 = tcp
  dns: "1" # 1 = system default, see options - https://github.com/angristan/openvpn-install/blob/master/openvpn-install.sh#L314-L327
  compression_enabled: "n"
  compression_choice: "1" # only works if compression_enabled is "y", 1 = LZ4-v2, 2 = LZ4, 3 = LZ0
  test_username: example # this will be used to create a client config in the `script_install_path` location
  #nat_endpoint: "$(curl -4 ifconfig.co)" # for servers behind NAT, see https://github.com/angristan/openvpn-install?tab=readme-ov-file#headless-install

```

<!--ENDROLEVARS-->
