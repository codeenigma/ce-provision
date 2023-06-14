# PHP Composer
This role is used to install the Composer package manager for PHP. It wraps the Galaxy role from Jeff Geerling which can be found here:

* https://github.com/geerlingguy/ansible-role-composer

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
php_composer:
  # Abstractions of default variables which can be found here:
  # https://github.com/geerlingguy/ansible-role-composer/blob/master/defaults/main.yml
  version: ''
  keep_updated: true
  version_branch: '--2' # install latest version 2.x by default
  github_oauth_token: ''

```

<!--ENDROLEVARS-->
