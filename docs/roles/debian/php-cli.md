# PHP terminal client

Installs and configures terminal client for PHP.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
php:
  cli:
    expose_php: "{% if _env_type == 'prod' %}Off{% else %}On{% endif %}"
    error_reporting: "{% if _env_type == 'prod' %}E_ALL & ~E_DEPRECATED & ~E_STRICT{% else %}E_ALL{% endif %}"
    display_errors: "{% if _env_type == 'prod' %}Off{% else %}On{% endif %}"
    display_startup_errors: "{% if _env_type == 'prod' %}Off{% else %}On{% endif %}"
    html_errors: "{% if _env_type == 'prod' %}Off{% else %}On{% endif %}"
    engine: "On"
    short_open_tag: "Off"
    max_execution_time: 120
    max_input_time: 60
    max_input_nesting_level: 64
    max_input_vars: 1000
    memory_limit: -1
    log_errors_max_len: 1024
    ignore_repeated_errors: "Off"
    ignore_repeated_source: "Off"
    post_max_size: 200M
    upload_max_filesize: 200M
    max_file_uploads: 20
    date_timezone: "Europe/London"
    gc_maxlifetime: 1440
    zend_assertions: -1
    overrides: {}
    opcache:
      enable: 1
      enable_cli: 0
      memory_consumption: 128
      max_accelerated_files: 2000
      validate_timestamps: 1

```

<!--ENDROLEVARS-->
