# Jenkins

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
ldap_client:
  endpoints: [""]
  lookup_base: ""
  lookup_user: ""
  binddn: ""
  bindpw: ""

jenkins:
  apt_signed_by: https://pkg.jenkins.io/debian/jenkins.io.key
  server_name: "jenkins.{{ _domain_name }}"
  ssl_handling: "ssl_selfsigned"
  listen_http_port: -1
  listen_https_port: 8884
  listen_bind_address: "0.0.0.0"
  keystore_pass: "cleartext"
  user: "jenkins"
  adminuser: "admin"
  adminpass: "{{ lookup('password', _ce_provision_data_dir + '/' + inventory_hostname + '/jenkins-adminpass') }}"
  # security: basic | ldap
  security: "basic"
  plugins:
    - ldap
    - mattermost
  ldap_endpoint: "{{ ldap_client.endpoints[0] }}"
  ldap_lookup_base: "{{ ldap_client.lookup_base }}"
  ldap_lookup_user: "{{ ldap_client.lookup_user }}"
  ldap_binddn: "{{ ldap_client.binddn }}"
  ldap_bindpw: "{{ ldap_client.bindpw }}"
  mailto: "admins@example.com"
  # daily key renewal execution with systemd timer
  on_calendar: "*-*-* 02:15:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events

```

<!--ENDROLEVARS-->
