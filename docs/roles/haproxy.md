# HA Proxy

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_haproxy:
  ssl_handling: ssl_selfsigned

haproxy:
  template: "haproxy-ssl-passthru"
  ssl_handling: "{{ _haproxy.ssl_handling }}"
  listen_bind_address: "0.0.0.0"
  listen_https: true
  listen_http: false
  default_backend: default
  backends:
    - name: default
      ip: 127.0.0.1
      port: 8080
      domain: "{{ _domain_name }}"

```

<!--ENDROLEVARS-->
