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
  version: '1.8.4' # Buster apt package is 'Composer 1.8.4 2019-02-11 10:52:10'
  keep_updated: false
  version_branch: ''
  github_oauth_token: ''

```

<!--ENDROLEVARS-->
