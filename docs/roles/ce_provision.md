# ce-provision
Installs Code Enigma's infrastructure management stack on a server.
<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
_ce_provision:
  username: "{% if is_local is defined and is_local %}ce-dev{% else %}provision{% endif %}"

ce_provision:
  username: "{{ _ce_provision.username }}"
  # Main repo.
  own_repository: "https://github.com/codeenigma/ce-provision.git"
  own_repository_branch: "master"
  own_repository_skip_checkout: false
  # Destination.
  local_dir: "/home/{{ _ce_provision.username }}/ce-provision"
  # Private config repo.
  config_repository: ""
  config_repository_branch: "master"
  config_repository_skip_checkout: false
  # Extra config repo.
  extra_repository: ""
  extra_repository_branch: "master"
  extra_repository_skip_checkout: false
  extra_repository_vars_file: "custom.yml"
  # Wether to commit back changes to extra repo.
  extra_repository_push: false
  extra_repository_allowed_vars: []
  # List of additional groups to add the user to.
  groups: []
  # File containing default roles and collections to install via Ansible Galaxy.
  galaxy_custom_requirements_file: "/home/{{ _ce_provision.username }}/ce-provision/config/files/galaxy-requirements.yml"

```

<!--ENDROLEVARS-->
