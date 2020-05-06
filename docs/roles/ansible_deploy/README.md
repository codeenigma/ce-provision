# ansible-deploy
Installs Code Enigma's deploy stack on a server.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---

_ansible_deploy:
username: "{% if is_local is defined and is_local %}ce-dev{% else %}deploy{% endif %}"

ansible_deploy:
username: "{{ _ansible_deploy.username }}"
own_repository: "https://github.com/codeenigma/ansible-deploy.git"
own_repository_branch: "master"
config_repository: ""
config_repository_branch: "master"
local_dir: "/home/{{ _ansible_deploy.username }}/ansible-deploy"
# List of additional groups to add the user to.
groups: ''

```

<!--ENDROLEVARS-->
