# OpenVPN Config
This role is used to install an OpenVPN server with an Ansible Galaxy role and corresponding configuration afterwards. The Galaxy role is here:

* https://galaxy.ansible.com/robertdebock/openvpn

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
openvpn_config:
  install: true # set to false if we do not want to overwrite the existing VPN certs

  # Defaults from https://github.com/robertdebock/ansible-role-openvpn/blob/master/vars/main.yml
  configuration_directory: /etc/openvpn
  easyrsa_path: /usr/share/easy-rsa
  service: "openvpn@server"
  server_ip_range: "server 10.8.0.0 255.255.255.0"
  # Additional options
  force_redirect_gateway: true
  compress: true
  no_client_cert: true
  custom_directives: [] # optional list of directives, i.e. push routes
    # - directive 1
    # - directive 2
    # - directive N

  # easy-rsa vars for generating VPN certs
  certs:
    cn: "{{ _domain_name }}"
    dn_mode: org # choices are org or cn_only
    country: US
    province: California
    city: San Francisco
    org: Copyleft Certificate Co
    email: me@example.com
    org_unit: My Organizational Unit

  # LDAP configuration
  ldap:
    install: false
    url: ldaps://ldap.example.com,ldaps://ldap2.example.com
    tls: false # set to true to use TLS on port 389 / ldap://
    tls_cert: /etc/ldap/ssl/ldap.CA.pem
    tls_cert_local: "" # Set this to the path on the Ansible controller if you want to copy it to the target
    timeout: '15'
    basedn: dc=example,dc=com
    search_filter: (&(objectClass=posixAccount)(uid=%u))
    require_group: true # set to false to allow any valid user in the basedn to login
    group_basedn: ou=Groups,dc=example,dc=com
    group_filter: (|(cn=vpnguests)(cn=sysadmins))

  # PAM configuration - you need to manage the anthentication methods for your VPN via pam_config
  # By default we assume the pam_ldap role is installed and configured
  # VPN auth will be carried out against the nslcd daemon settings
  pam:
    install: false
    pam_config: |
      auth sufficient pam_ldap.so
      auth required pam_deny.so

      account required pam_ldap.so
      account required pam_permit.so

```

<!--ENDROLEVARS-->
