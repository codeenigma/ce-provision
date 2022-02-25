# ce-deploy
Installs Code Enigma's deploy stack on a server.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_ce_deploy:
  username: "{% if is_local is defined and is_local %}ce-dev{% else %}deploy{% endif %}"

ce_deploy:
  username: "{{ _ce_deploy.username }}"
  own_repository: "https://github.com/codeenigma/ce-deploy.git"
  own_repository_branch: "master"
  config_repository: ""
  config_repository_branch: "master"
  local_dir: "/home/{{ _ce_deploy.username }}/ce-deploy"
  asg_processes_policy_name: "DeployManageASGProcesses"
  # List of additional groups to add the user to.
  groups: []

```

<!--ENDROLEVARS-->
