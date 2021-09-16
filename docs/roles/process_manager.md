# Process Manager
Although there is the `ansible.builtin.service` module for manipulating services, if services do not stop cleanly this can cause problems. This role attempts to first stop and disable a service with the proper module, but if that fails it follows up with `pkill` and `kill -9` commands for any trailing processes, to ensure the service is truly stopped.

<!--TOC-->
<!--ENDTOC-->

# Configuration
This role expects only the service name as a variable, it has a concept of pluggable operations but for now only the `stop` operation exists.

<!--ROLEVARS-->
## Default variables
```yaml
---
process_manager:
  operation: stop
  process_name: "" # the name of the process to manage

```

<!--ENDROLEVARS-->
