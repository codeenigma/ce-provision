# PHP-FPM

Installs and configures the PHP-FPM flavour of FastCGI.

Note, for legacy reasons this role sets up PHP-FPM to use TCP/IP instead of a Unix socket by default. However, we *recommend* you change this by setting `unix_socket: true` unless you really need to run PHP-FPM over TCP/IP, as a Unix socket is much faster. If you do, be sure to set the `pool_group` variable to match your web server user, or the web server will be unable to interact with PHP.

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
    unix_socket: false  # set to true to use a unix socket, you must also update nginx and cachetool if you do
    server_ip: "127.0.0.1"
    tcp_port: ""  # leave empty to automate port selection - port will be "90{{ version | replace('.','') }}" - e.g. 9081 for PHP 8.1
    pool_user: "{{ user_deploy.username }}"   # this should always be the deploy user, usually deploy
    pool_group: "{{ user_deploy.username }}"  # if using unix socket this should be the web server user, often www-data
    pm: dynamic # can also be static, see https://tideways.com/profiler/blog/an-introduction-to-php-fpm-tuning
    default_socket_timeout: 60
    # It is important to scale up processes on bigger servers, so that more
    # requests can be handled. Double the number of vCPUs is a good default.
    # Can be between 5 and 64.
    max_children: "{{ [10, [(ansible_facts.ansible_processor_nproc | default(1)) * 2, 64] | min] | max }}"  # Fallback in case ansible_processor_nproc is not gathered before tasks
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
      interned_strings_buffer: 8
    clear_env: "yes"
    # Cloudwatch log settings.
    log_group_prefix: ""
    log_stream_name: example

```

<!--ENDROLEVARS-->
