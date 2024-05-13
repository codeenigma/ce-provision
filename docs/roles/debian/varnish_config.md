# varnish_config
Installs and configures Varnish, with 6.4 being the default version. Depends on `geerlingguy.varnish` which does the setup bit, `varnish_config` handles the `default.vcl` file.

You can provide a template override in two locations, they will be checked in this order:
* `templates` in the same directory as your server's playbook
* `files/templates` in your `ce-provision-config` repository

If no alternative is found, the `default.vcl.j2` template provided with this role is used. By default the override template is expected to be named `default.vcl.j2`, however if you set `varnish_config.template_filename` you can change this. For example, if you place a template at `files/templates/my-app.v1.vcl.j2` in your config repository, you need to set the variable as follows, note *without* the `.j2` which is implicit:

```yaml
varnish_config:
  template_filename: my-app.v1.vcl
```

This behaviour allows you to manage different Varnish templates for different applications. You may of course provide your own variables in the `varnish_config` dictionary for your custom template.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
# Defaults file for varnish_config, other variables exist from importing geerlingguy.varnish and can be overriden

varnish_config:
  # List of IPs that are allowed to ask for content purge.
  allowed_purge_IP: []
  # Paths that won't be cached.
  bypass_cache_paths: install\.php|update\.php|cron\.php
  # Set this to the actual host you want to force instead of false.
  forced_host_header: false
  pipe_large_assets: false
  # If needed, set the two following variables to true and the actual host you want to redirect to.
  redirect_host: false
  redirect_host_destination: ""
  strip_cookies: (^|;\s*)(_[_a-z]+|has_js|AWSELB|cookie-agreed)=[^;]*
  # List of upstream proxies we trust to set X-Forwarded-For correctly, use either CIDR or list all the IPs.
  upstream_proxies: []
  # Provide an alternative filename if you are providing a template.
  template_filename: default.vcl

```

<!--ENDROLEVARS-->
