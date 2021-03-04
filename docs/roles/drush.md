# Drush
Installs the `drush` command-line tool for the deploy user.
<!--ROLEVARS-->
## Default variables
```yaml
---
drush:
  # Note: This is the "default" version,
  # but projects should define theirs in composer.json.
  version: 8.4.5
  # The user where drush is to be installed
  drush_user: "deploy"
```

<!--ENDROLEVARS-->
