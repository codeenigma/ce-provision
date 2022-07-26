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
  new_user: true # set to false if user already exists or is ephemeral, e.g. an LDAP user
  key_name: id_rsa.pub # existing users may have a key of a different name
  username: "{{ _ce_deploy.username }}"
  own_repository: "https://github.com/codeenigma/ce-deploy.git"
  own_repository_branch: "master"
  config_repository: ""
  config_repository_branch: "master"
  local_dir: "/home/{{ _ce_deploy.username }}/ce-deploy"
  # List of additional groups to add the user to.
  groups: []

```

<!--ENDROLEVARS-->
