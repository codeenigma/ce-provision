# ce-provision
A set of Ansible roles and wrapper scripts to configure remote (Debian) machines.
## Overview
The "stack" from this repo is to be installed on a "controller" server/runner, to be used in conjonction with a CI/CD tool (Jenkins, Gitlab, Travis, ...).
It allows the configuration for a given service to be easily customizable at will, and to be stored in a git repository.
When triggered from a deployment tool, the stack will clone the codebase and "play" a given deploy playbook from there.

<!--TOC-->
## [Install](install/README.md)
You can install either:
- through [ce-provision](https://github.com/codeenigma/ce-provision)
- manually by running a local playbook
- with Docker (soon)

### [Install manually](install/README.md#install-manually)
### [Install with ce-provision](install/README.md#install-with-ce-provision)
### [Install with Docker](install/README.md#install-with-docker)
### [Configuration](install/README.md#configuration)
## [Usage](scripts/README.md)
While you can re-use/fork roles or call playbooks directly from your deployment tool, it is recommended to use the provided wrapper scripts, as they will take care of setting up the needed environments.
### [Deploy with the "build" script](scripts/README.md#deploy-with-the-build-script)
### [Deploy with individual steps](scripts/README.md#deploy-with-individual-steps)
## [Roles](roles/README.md)
Ansible roles and group of roles that constitute the deploy stack.
### ["Meta" roles that group individual roles together.](roles/_meta/README.md)
### [AWS tools roles](roles/aws/README.md)
## [Contribute](contribute/README.md)

### [Documentation](contribute/README.md#documentation)
<!--ENDTOC-->

<a href="https://github.com/codeenigma/ce-provision/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=codeenigma/ce-provision" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
