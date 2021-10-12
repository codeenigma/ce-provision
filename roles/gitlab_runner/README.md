# Gitlab Runner
Install the Gitlab Runner binary from .deb package.
<!--TOC-->
<!--ENDTOC-->

If you want to use AWS ECS with Fargate for orchestrating CI containers then set `fargate: true` in your variables to install the driver.

<!--ROLEVARS-->
## Default variables
```yaml
---
gitlab_runner:
  fargate: false

```

<!--ENDROLEVARS-->
