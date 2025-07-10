# LDAP Server
Install `slapd` and dependencies to run an LDAP directory server.

<!--TOC-->
<!--ENDTOC-->

## Configuration
By default the role simply installs `slapd` and nothing else. However, you can import configuration from an LDIF file using `slapadd`. To create a config file from another LDAP server use this command:

* `slapcat -n 0 > /path/to/my/backup.ldif`

Place this file in the directory referenced in the `ldap_server.config.path` variable and set `ldap_server.config.import` to `true` and Ansible will attempt to import your config. You may have your config spread across multiple LDIF files, this is fine - put them all in the same directory and name them alphabetically if process order is important. By default the role expects the config to be stored in your `ce-provision-config` repository.

SSL is optional but if you do use it then you will be obliged to use the `manual` handling type of the SSL role, because LDAP expects a separate CA certificate file and only `manual` supports that. See the `ssl` role documentation for details.

This role does not try to import actual directory data, it concerns itself only with configuring a server. If you want to import data, you can export it from another server using `slapcat` in a similar way to the config, the only change is the database number:

* `slapcat -n 1 > /path/to/my/data.ldif`

Because this is sensitive data, you probably do not want to store it anywhere, rather import it and destroy it. If you want to write a private play to import your data, here's a sample from our own private LDAP project:

```yaml
---
- name: Stop slapd service. # you must stop the service or the database will be locked
  ansible.builtin.service:
    name: slapd
    state: stopped

# This is defending against a specific bug with Docker and the init script - https://stackoverflow.com/questions/30671693
- name: Ensure running slapd processes are killed.
  ansible.builtin.command:
    cmd: pkill slapd
  failed_when: false

- name: Copy LDAP data from config repo. # we've temporarily placed the directory data on our controller, this copies it to the LDAP server
  ansible.builtin.copy:
    src: "{{ _ce_provision_base_dir }}/config/files/ldap_server/data/data.ldif"
    dest: /usr/local/src/custom-ldap-schemas/data.ldif
    owner: openldap
    group: openldap
    mode: 0644

- name: Import our LDAP data.
  ansible.builtin.command:
    cmd: "slapadd -F /etc/ldap/slapd.d -n 1 -l /usr/local/src/custom-ldap-schemas/data.ldif"
  become_user: openldap
  become: true

- name: Start slapd service.
  ansible.builtin.service:
    name: slapd
    state: started
```

If you create a similar role on your controller server or in your config repository you can have Ansible import your data.

## Replication
By default replication settings are not applied. If you want to set up a server to replicate another, existing LDAP host, you can set the details in `ldap_server.replication`. Note, passwords will be plain text so it is strongly advised you SOPS encrypt them before storing them in a code repository.

The role sets up basic replication and makes no assumptions about permissions for the replication user it creates on the host. If you need to set special permissions for replication on the host machine then you should write a custom role. You can use `delegate_to: "{{ ldap_server.replication.host }}"` in your tasks to execute tasks against the LDAP host and still have access to all the variables set for the consumer.

This is a good general resource on LDAP replication and how to configure it: http://www.rjsystems.nl/en/2100-d6-openldap-consumer.php

<!--ROLEVARS-->
## Default variables
```yaml
---
ldap_server:
  slapd:
    user: openldap
    services: "ldap:/// ldapi:/// ldaps:///"
    ulimit: "8192"
    options: ""
    purge: false # Use this only for a completely clean install.
  # For safety, by default no config handling will occur. Use these variables to enable and provide LDIF files.
  config:
    import: false
    # The path to your LDIF files which define your schema.
    # All organisations have a different schema so this should be kept in your config repository.
    # Execution order can be important, so ensure your files are named in alphabetical order.
    path: "{{ _ce_provision_base_dir }}/config/files/ldap_server/config"
    purge: false
    backup: false # set to true to create local backups of LDAP
    backup_path: /opt/slap-bak
    backup_script: /usr/local/bin/slap-bak # full filename of the backup script
    slapcat_path: /usr/sbin # path to the location of slapcat on the server
    on_calendar: "*-*-* 23:45:00" # see systemd.time documentation - https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events
  # TLS settings in LDAP are not separately handled, you need to manually set it up or use the config import feature.
  # If you use 'manual' SSL handling you need to provide a separate CA certificate.
  # If you use 'letsencrypt' SSL handling then the LDAP TLS settings in your imported config should be as follows:
  #   olcTLSCACertificateFile: /etc/letsencrypt/live/{{ _domain_name }}/chain.pem
  #   olcTLSCertificateFile: /etc/letsencrypt/live/{{ _domain_name }}/cert.pem
  #   olcTLSCertificateKeyFile:  /etc/letsencrypt/live/{{ _domain_name }}/privkey.pem
  ssl: # @see the 'ssl' role - does nothing by default.
    replace_existing: false
    domain: "{{ _domain_name }}"
    handling: "unmanaged"
    key: ""
    cert: ""
    ca_cert: ""
    # Sample LetsEncrypt config, because include_role will not merge defaults these all need providing:
    # handling: letsencrypt
    # http_01_port: 5000
    # autorenew: true
    # email: sysadm@codeenigma.com
    # services: []
    # web_server: standalone
    # certbot_register_command: "certonly --agree-tos --preferred-challenges http -n"
    # certbot_renew_command: "certonly --agree-tos --force-renew"
    # reload_command: restart
    # reload:
    #   - slapd
    # on_calendar: "Mon *-*-* 04:00:00"
  replication:
    host: "" # host must be present in config/hosts for ce-provision, leave empty if no replication is desired
    port: "636"
    searchbase: "dc=example,dc=com"
    admin_cn: "cn=admin" # the admin user's canonical name, assumed to be the same on host and consumer
    admin_pwd: "" # the host admin bind password
    bind_cn: "cn={{ _domain_name }}" # the canonical name of the user on the host with read access to fetch changes
    bind_pwd: "" # the desired replication user password - will be generated if not provided
    interval: "00:00:07:00" # defaults to every 7 minutes

```

<!--ENDROLEVARS-->
