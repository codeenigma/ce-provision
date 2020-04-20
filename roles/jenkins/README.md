# Jenkins

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---

ldap_client:
  endpoints: ['']
  lookup_base: ""
  lookup_user: ""
  binddn: ""
  bindpw: ""

jenkins:
  server_name: "jenkins.{{ domain_name }}"
  ssl_handling: "ssl_selfsigned"
  listen_http_port: -1
  listen_https_port: 8884
  listen_bind_address: "0.0.0.0"
  keystore_pass: "cleartext"
  user: "jenkins"
  adminuser: "admin"
  adminpass: ""
  # security: basic | ldap 
  security: "basic"
  plugins:
    - ldap
  ldap_endpoint: "{{ ldap_client.endpoints[0] }}"
  ldap_lookup_base: "{{ ldap_client.lookup_base }}"
  ldap_lookup_user: "{{ ldap_client.lookup_user}}"
  ldap_binddn: "{{ ldap_client.binddn }}"
  ldap_bindpw: "{{ ldap_client.bindpw }}"
  mailto: "admins@example.com"
  schedule: '0 0 * * *'
  sshhost: "localhost"
  sshport: 38884

```

<!--ENDROLEVARS-->
