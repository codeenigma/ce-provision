# PHP-FPM

Installs and configures the PHP-FPM flavour of FastCGI.

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
php:
  # see php-common for default version
  fpm:
    # FPM settings - official documentation is here: https://www.php.net/manual/en/install.fpm.configuration.php
    unix_socket: false # set to true to use a unix socket, you must also update nginx and cachetool if you do
    server_ip: "127.0.0.1"
    tcp_port: "" # leave empty to automate port selection - port will be "90{{ version | replace('.','') }}" - e.g. 9081 for PHP 8.1
    pool_user: "{{ user_deploy.username }}"
    pool_group: "{{ user_deploy.username }}" # if using unix socket this should be the web server user
    pm: dynamic # can also be static, see https://tideways.com/profiler/blog/an-introduction-to-php-fpm-tuning
    default_socket_timeout: 60
    max_children: 5
    start_servers: 2
    min_spare_servers: 1
    max_spare_servers: 3
    process_idle_timeout: 10s
    max_requests: 500
    request_terminate_timeout: 0
    rlimit_core: 0 # Possible Values: 'unlimited' or an integer greater or equal to 0; Default Value: 0
    slow_log: true
    request_slowlog_timeout: 0
    slowlog_file_directory: "/home/{{ user_deploy.username }}"
    # PHP ini file settings
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
    memory_limit: 256M
    log_errors_max_len: 1024
    ignore_repeated_errors: "Off"
    ignore_repeated_source: "Off"
    post_max_size: 200M
    upload_max_filesize: 200M
    max_file_uploads: 20
    date_timezone: "Europe/London"
    gc_maxlifetime: 1440
    cookie_lifetime: 0
    zend_assertions: -1
    session_cookie_secure: "Off"
    opcache:
      enable: 1
      enable_cli: 0
      memory_consumption: 128
      max_accelerated_files: 2000
      validate_timestamps: 1
    clear_env: "yes"

```

<!--ENDROLEVARS-->
