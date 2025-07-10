# Docker Registry
Provides a local Docker registry, predominantly used by [`ce-dev`](https://github.com/codeenigma/ce-dev/) and the `push` and `pull` commands, but can be used to create a Docker registry on any target host. It uses the official Docker registry image to spin up a container on the target host which hosts the registry. The provided `docker-compose.yml.j2` template can be overridden to provide an alternative Docker Compose service configuration.

<!--ROLEVARS-->
## Default variables
```yaml
---
docker_registry:
  bind: 127.0.0.1
  port: 5000
  image_version: "2.8.3" # see https://hub.docker.com/_/registry
  # Whether it is behind an Nginx proxy (for auth).
  proxy: false
nginx:
  client_max_body_size: 0

```

<!--ENDROLEVARS-->
