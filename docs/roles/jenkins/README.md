# Jenkins

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---

jenkins:
server_name: "jenkins.{{ domain_name }}"
ssl_handling: "ssl_selfsigned"
listen_http_port: -1
listen_https_port: 8884
listen_bind_address: "0.0.0.0"
keystore_pass: "cleartext"
user: "jenkins"


```

<!--ENDROLEVARS-->
