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
### [AWS tools roles](roles/aws/README.md)
### [UFW Firewall](roles/firewall/README.md)

### [Gitlab](roles/gitlab/README.md)

### [HA Proxy](roles/haproxy/README.md)

### [Jenkins](roles/jenkins/README.md)

### ["Meta" roles that group individual roles together.](roles/meta/README.md)

### [MariaDB Client](roles/mysql_client/README.md)
### [opcache](roles/opcache/README.md)

Installs and configures gordalina's cache tool: https://github.com/gordalina/cachetool

### [SSHD](roles/ssh_server/README.md)

## [Contribute](contribute/README.md)

<!--ENDTOC-->
