# ansible-provision
A set of Ansible roles and wrapper scripts to configure remote (Debian) machines.
## Overview
The "stack" from this repo is to be installed on a "controller" server/runner, to be used in conjonction with a CI/CD tool (Jenkins, Gitlab, Travis, ...).
It allows the configuration for a given service to be easily customizable at will, and to be stored in a git repository.
When triggered from a deployment tool, the stack will clone the codebase and "play" a given deploy playbook from there.

<!--TOC-->
## [Install](install/README.md)
You can install either:
- through [ansible-provision](https://github.com/codeenigma/ansible-provision)
- manually by running a local playbook
- with Docker (soon)

## [Usage](scripts/README.md)
While you can re-use/fork roles or call playbooks directly from your deployment tool, it is recommended to use the provided wrapper script, as it will take care of setting up the needed environments variables.
## [Roles](roles/README.md)
Ansible roles and group of roles that constitute the deploy stack.
### [Ansible](roles/ansible/README.md)
### [ansible-deploy](roles/ansible_deploy/README.md)
Installs Code Enigma's deploy stack on a server.
### [ansible-provision](roles/ansible_provision/README.md)
Installs Code Enigma's infrastructure management stack on a server.
### [Extra packages](roles/apt_extra_packages/README.md)
Provides a wrapper for installing packages through apt.
### [AWS tools roles](roles/aws/README.md)
### [Extra packages](roles/ce_dev/README.md)
Provides a wrapper for installing packages through apt.
### [ClamAV Clamscan](roles/clamav_clamscan/README.md)

### [ClamAV Daemon](roles/clamav_daemon/README.md)

### [UFW Firewall](roles/firewall/README.md)

### [Gitlab](roles/gitlab/README.md)

### [Gitlab Runner](roles/gitlab_runner/README.md)
Install the Gitlab Runner binary from .deb package.
### [GPG Key](roles/gpg_key/README.md)
Generates a passwordless GPG key for a given user or users.
### [HA Proxy](roles/haproxy/README.md)

### [Managed /etc/hosts](roles/hosts/README.md)
Forked from https://github.com/bertvv/ansible-role-hosts

### [Jenkins](roles/jenkins/README.md)

### ["Meta" roles that group individual roles together.](roles/meta/README.md)

### [MariaDB Client](roles/mysql_client/README.md)
### [opcache](roles/opcache/README.md)

Installs and configures gordalina's cache tool: https://github.com/gordalina/cachetool

### [defaults file for ossec](roles/ossec/README.md)

ossec:
client: true								# if client is true installs the ossec agent, if false installs the server
serverip: "123.123.123.123"						# server IP in case of client false

global:
email_notification: "yes"
email_to: "admin@example.com"
smtp_server: "mail.google.com"
email_from: "admin@example.com"
white_list:
- "8.8.8.8"
- "4.4.4.4"
alerts:
log_alert_level: 1
email_alert_level: 7

email_alerts:
email_to: "admin@example.com"
level: 14

syscheck:
frequency: 79200
directories:
- /etc
- /usr/bin
- /usr/sbin
- /bin
- /sbin
ignore:
- /etc/mtab
- /etc/mnttab
- /etc/hosts.deny
- /etc/mail/statistics
- /etc/random-seed
- /etc/adjtime
- /etc/httpd/logs
- /etc/utmpx
- /etc/wtmpx
- /etc/cups/certs
- /etc/dumpdates
- /etc/svc/volatile
- /etc/puppet
- /etc/resolv.conf
- /etc/hybserv

rootcheck:
disabled: "no"
rootkit_files:
- /var/ossec/etc/shared/rootkit_files.txt
rootkit_trojans:
- /var/ossec/etc/shared/rootkit_trojans.txt
system_audit:
- /var/ossec/etc/shared/system_audit_rcl.txt
- /var/ossec/etc/shared/cis_debian_linux_rcl.txt
- /var/ossec/etc/shared/cis_rhel_linux_rcl.txt
- /var/ossec/etc/shared/cis_rhel5_linux_rcl.txt

command:
- { name: 'firewall-drop', executable: 'firewall-drop.sh', expect: 'srcip', timeout_allowed: 'yes' }

activeresponse:
- { disabled: 'no', command: 'firewall-drop', location: 'all', rules_id: '31151,5712,104130,101071,101132,101238,101251,103011', repeated_offenders: '30,60,120', timeout: '600' }
- { disabled: 'no', command: 'firewall-drop', location: 'all', rules_id: '100205', repeated_offenders: '30,60,120', timeout: '3600' }

remote:
connection:
- syslog
- secure

localfile:
- { log_format: 'syslog', location: '/var/log/messages' }
- { log_format: 'syslog', location: '/var/log/auth.log' }
- { log_format: 'syslog', location: '/var/log/syslog' }
- { log_format: 'syslog', location: '/var/log/mail.info' }
- { log_format: 'syslog', location: '/var/log/dpkg.log' }

rules:								# all *_rules.xml files will be copied over
- rules_config.xml							# for customer rules you can create customerX_rules.xml
- pam_rules.xml
- sshd_rules.xml
- telnetd_rules.xml
- syslog_rules.xml
- arpwatch_rules.xml
- symantec-av_rules.xml
- symantec-ws_rules.xml
- pix_rules.xml
- named_rules.xml
- smbd_rules.xml
- vsftpd_rules.xml
- proftpd_rules.xml
- ms_ftpd_rules.xml
- ftpd_rules.xml
- hordeimp_rules.xml
- roundcube_rules.xml
- wordpress_rules.xml
- cimserver_rules.xml
- vpopmail_rules.xml
- vmpop3d_rules.xml
- courier_rules.xml
- web_rules.xml
- web_appsec_rules.xml
- apache_rules.xml
- nginx_rules.xml
- php_rules.xml
- mysql_rules.xml
- postgresql_rules.xml
- ids_rules.xml
- squid_rules.xml
- firewall_rules.xml
- cisco-ios_rules.xml
- netscreenfw_rules.xml
- sonicwall_rules.xml
- postfix_rules.xml
- sendmail_rules.xml
- imapd_rules.xml
- mailscanner_rules.xml
- dovecot_rules.xml
- ms-exchange_rules.xml
- racoon_rules.xml
- vpn_concentrator_rules.xml
- spamd_rules.xml
- msauth_rules.xml
- mcafee_av_rules.xml
- trend-osce_rules.xml
- ms-se_rules.xml
- zeus_rules.xml
- solaris_bsm_rules.xml
- vmware_rules.xml
- ms_dhcp_rules.xml
- asterisk_rules.xml
- ossec_rules.xml
- attack_rules.xml
- openbsd_rules.xml
- clam_av_rules.xml
- dropbear_rules.xml
- local_rules.xml


License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
### [SSHD](roles/ssh_server/README.md)

## [Contribute](contribute/README.md)

<!--ENDTOC-->
