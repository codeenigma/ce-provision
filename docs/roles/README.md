# Roles
Ansible roles and group of roles that constitute the deploy stack.
<!--TOC-->
## [AWS tools roles](aws/README.md)
### [AMI Debian Buster](aws/ami_debian_buster/README.md)
Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.

### [Amazon credentials](aws/aws_credentials/README.md)
Simple role generating credentials "profiles" in users $HOME/.aws/credentials.

### [AMI Debian Buster](aws/aws_ec2_with_eip/README.md)
Creates an image from Debian Buster base with Packer, provisioned with an Ansible Playbook.
### [AWS key pair.](aws/aws_provision_ec2_keypair/README.md)
Creates a key pair for the current "provision user"
## [ClamAV Clamscan](clamav_clamscan/README.md)

## [UFW Firewall](firewall/README.md)

## [Gitlab](gitlab/README.md)

## [GPG Key](gpg_key/README.md)
Generates a passwordless GPG key for a given user or users.
## [HA Proxy](haproxy/README.md)

## [Jenkins](jenkins/README.md)

## ["Meta" roles that group individual roles together.](meta/README.md)

## [MariaDB Client](mysql_client/README.md)
## [opcache](opcache/README.md)

Installs and configures gordalina's cache tool: https://github.com/gordalina/cachetool

## [SSHD](ssh_server/README.md)

<!--ENDTOC-->
