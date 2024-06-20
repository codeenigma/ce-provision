# wazuh
Wraps the [Wazuh Ansible roles](https://github.com/wazuh/wazuh-ansible) to configure Wazuh in various different scenarios, based on [the example configrations provided in the Wazuh documentation](https://documentation.wazuh.com/current/deployment-options/deploying-with-ansible/).

Supports standalone managers, scaled out services and agent installation (default).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
wazuh:
  path: wazuh
  #roles_directory: "/path/to/roles" # defaults to /home/controller/.ansible/roles/wazuh-ansible
  branch: "v4.7.2" # wazuh-ansible git branch to checkout - not to be confused with wazuh_version!
  # Agent variables, installed locally by default
  # Role defaults - https://github.com/wazuh/wazuh-ansible/blob/master/roles/wazuh/ansible-wazuh-agent/defaults/main.yml
  agent:
    install: true
    managers: [] # list of manager servers, e.g.
    #  - address: 10.0.0.1
    #    port: 1514
    #    protocol: tcp
    #    api_port: 55000
    #    api_proto: 'http'
    #    api_user: ansible
    #    max_retries: 5
    #    retry_interval: 5
    # Automated enrolment variables
    # See docs - https://documentation.wazuh.com/current/user-manual/reference/ossec-conf/client.html
    wazuh_agent_enrollment:
      enabled: "yes"
      agent_name: ""
      groups: "" # comma-separated list of group names corresponding to `agent_groups` under manager config below
      agent_address: ""
      ssl_ciphers: HIGH:!ADH:!EXP:!MD5:!RC4:!3DES:!CAMELLIA:@STRENGTH
  # Indexer variables, default to single node mode
  # Role defaults - https://github.com/wazuh/wazuh-ansible/blob/master/roles/wazuh/wazuh-indexer/defaults/main.yml
  indexer:
    install: false # install the indexer packages
    single_node: true
    domain_name: indexer.example.com # possible to use "{{ _domain_name }}" in local variables, but not defaults
    indexer_cluster_name: wazuh
    indexer_node_name: node-1 # this server name
    indexer_network_host: 127.0.0.1
    indexer_http_port: 9200
    indexer_api_protocol: https
    indexer_custom_user: ""
    indexer_custom_user_role: "admin"
    indexer_admin_password: changeme
    minimum_master_nodes: 1
    indexer_node_master: true
    indexer_node_data: true
    indexer_node_ingest: true
    indexer_start_timeout: 90
    indexer_cluster_nodes:
      - 127.0.0.1
    indexer_discovery_nodes:
      - 127.0.0.1
    # dicts of instances for use in indexer templates
    indexer_primary: # primary instance
      node-1:
        name: node-1
        ip: 127.0.0.1
        role: indexer
    indexer_instances: # dict of all available instances - matches index_primary when single_node is `true`
      node-1:
        name: node-1
        ip: 127.0.0.1
        role: indexer
  # Filebeat variables, default to Wazuh stack on a single server
  # Role defaults - https://github.com/wazuh/wazuh-ansible/blob/master/roles/wazuh/ansible-filebeat-oss/defaults/main.yml
  filebeat:
    install: false # install the filebeat packages
    filebeat_version: 7.10.2
    filebeat_node_name: node-1
    filebeat_output_indexer_hosts:
      - "127.0.0.1:9200" # make sure the specified port matches indexer.indexer_http_port
    filebeat_module_package_url: https://packages.wazuh.com/4.x/filebeat
    filebeat_module_package_name: wazuh-filebeat-0.2.tar.gz
    indexer_security_user: admin
    indexer_security_password: changeme
  # Manager variables
  # Role defaults - https://github.com/wazuh/wazuh-ansible/blob/master/roles/wazuh/ansible-wazuh-manager/defaults/main.yml
  manager:
    install: false # install the manager packages
    wazuh_manager_mailto:
      - admin@example.net
    wazuh_manager_email_smtp_server: localhost
    wazuh_manager_email_from: wazuh@example.net
    wazuh_manager_email_maxperhour: 12
    wazuh_manager_email_queue_size: 131072
    wazuh_manager_email_log_source: alerts.log
    wazuh_manager_log_level: 3
    wazuh_manager_email_level: 12
    wazuh_manager_whitelist: 1.1.1.1
    agent_groups: [] # maps to `groups` string in agent config above
    wazuh_manager_extra_emails: [] # list of additional emails to send, e.g.
      #- enable: true
      #  mail_to: 'recipient@example.wazuh.com'
      #  format: full
      #  level: 7
      #  event_location: null
      #  group: null
      #  do_not_delay: false
      #  do_not_group: false
      #  rule_id: null
    wazuh_manager_reports: [] # list of reports to send, e.g.
      #- enable: true
      #  category: 'syscheck'
      #  title: 'Daily report: File changes'
      #  email_to: admin@example.net
      #  location: null
      #  group: null
      #  rule: null
      #  level: null
      #  srcip: null
      #  user: null
      #  showlogs: null
    wazuh_manager_api:
      bind_addr: 0.0.0.0
      port: 55000
      behind_proxy_server: "no"
      https: "yes"
      https_key: "api/configuration/ssl/server.key"
      https_cert: "api/configuration/ssl/server.crt"
      https_use_ca: false
      https_ca: "api/configuration/ssl/ca.crt"
      logging_level: "info"
      logging_path: "logs/api.log"
      cors: "no"
      cors_source_route: "*"
      cors_expose_headers: "*"
      cors_allow_headers: "*"
      cors_allow_credentials: "no"
      cache: "yes"
      cache_time: 0.750
      access_max_login_attempts: 5
      access_block_time: 300
      access_max_request_per_minute: 300
      drop_privileges: "yes"
      experimental_features: "no"
      remote_commands_localfile: "yes"
      remote_commands_localfile_exceptions: []
      remote_commands_wodle: "yes"
      remote_commands_wodle_exceptions: []
      #wazuh_api_users:
      #  - username: custom-user
      #    password: .S3cur3Pa55w0rd*- # Must comply with requirements (8+ length, uppercase, lowercase, specials chars)
  # Dashboard variables, default to Wazuh stack on a single server
  # Role defaults - https://github.com/wazuh/wazuh-ansible/blob/master/roles/wazuh/wazuh-dashboard/defaults/main.yml
  dashboard:
    install: false # install the dashboard packages
    dashboard_node_name: node-1
    dashboard_server_host: "0.0.0.0"
    dashboard_server_port: "443" # if you want to use provided SSL certificates install a web server and proxy to Wazuh
    dashboard_server_name: dashboard.example.com # possible to use "{{ _domain_name }}" in local variables, but not defaults
    dashboard_conf_path: "/etc/wazuh-dashboard/"
    wazuh_api_credentials:
      - id: "default"
        url: "https://localhost" # localhost when the Wazuh stack is on a single server
        port: 55000 # must match wazuh_manager_api.port
        username: "wazuh" # these user attributes are required to stop the play failing, even if wazuh_api_users is not set
        password: "wazuh"
    dashboard_security: true
    dashboard_user: kibanaserver
    dashboard_password: changeme

```

<!--ENDROLEVARS-->
