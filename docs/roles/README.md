# Roles
Ansible roles and group of roles that constitute the deploy stack.
<!--TOC-->
## [Ansible](ansible/README.md)
## [ce-deploy](ce_deploy/README.md)
Installs Code Enigma's deploy stack on a server.
## [ce-provision](ce_provision/README.md)
Installs Code Enigma's infrastructure management stack on a server.
## [Extra packages](apt_extra_packages/README.md)
Provides a wrapper for installing packages through apt.
## [AWS tools roles](aws/README.md)
### [AMI Debian Buster](aws/ami_debian_buster/README.md)
Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.

### [Amazon credentials](aws/aws_credentials/README.md)
Simple role generating credentials "profiles" in users $HOME/.aws/credentials.

### [Autoscale cluster](aws/aws_ec2_autoscale_cluster/README.md)

### [AMI Debian Buster](aws/aws_ec2_with_eip/README.md)
Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.
### [EFS client](aws/aws_efs_client/README.md)
Mounts EFS volume(s) to specific mount point(s).
It uses the "Name" tag for a given volume to retrieve the volume path.
### [AWS key pair.](aws/aws_provision_ec2_keypair/README.md)
Creates a key pair for the current "provision user"
### [Update main route for a given VPC](aws/aws_vpc_main_route/README.md)
This will add/update routes on the "main" route table for a given VPC, leaving existing routes for different CIDR blocks intact.
### [VPC](aws/aws_vpc_with_subnets/README.md)
Creates a VPC and associated subnets.
## [Extra packages](ce_dev/README.md)
Provides a wrapper for installing packages through apt.
## [ClamAV Clamscan](clamav_clamscan/README.md)

## [ClamAV Daemon](clamav_daemon/README.md)

## [UFW Firewall](firewall/README.md)

## [Gitlab](gitlab/README.md)

## [Gitlab Runner](gitlab_runner/README.md)
Install the Gitlab Runner binary from .deb package.
## [GPG Key](gpg_key/README.md)
Generates a passwordless GPG key for a given user or users.
## [HA Proxy](haproxy/README.md)

## [Managed /etc/hosts](hosts/README.md)
Forked from https://github.com/bertvv/ansible-role-hosts

## [Jenkins](jenkins/README.md)

## ["Meta" roles that group individual roles together.](meta/README.md)

## [MariaDB Client](mysql_client/README.md)
## [opcache](opcache/README.md)

Installs and configures gordalina's cache tool: https://github.com/gordalina/cachetool

## [defaults file for ossec](ossec/README.md)

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
## [SSHD](ssh_server/README.md)

<!--ENDTOC-->
