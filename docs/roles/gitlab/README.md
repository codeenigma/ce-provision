# Gitlab

<!--TOC-->
<!--ENDTOC-->
## Configuration
Because of the size of the gitlab.rb file, it is impractical to try to parameterized it.
Only a few basic variables are thus provided. To further customize it, the recommended approach is to leverage the "override" system and provide a custom template.

<!--ROLEVARS-->
## Default variables
```yaml
---
# See https://github.com/ansible/ansible/issues/8603

gitlab:
server_name: "gitlab.{{ domain_name }}"
ssl_handling: "ssl_selfsigned"
unicorn_worker_processes: 2
nginx:
listen_port: 8881
listen_https: nil
client_max_body_size: '250m'
redirect_http_to_https: 'false'
redirect_http_to_https_port: 8881

```

<!--ENDROLEVARS-->
