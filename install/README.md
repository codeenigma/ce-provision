# Install
You can install either:
- through [ansible-provision](https://github.com/codeenigma/ansible-provision)
- manually by running a local playbook
- with Docker (soon)

## Install manually
### Dependencies
The stack has been created on Debian Buster. It might run on other Debian versions or derivatives, but this is untested.
The main prerequesites are obviously Ansible and git. Depending on how you setup your inventory, you might need some other Python libraries (eg Boto3 for AWS).
You will also need a local user to install locally, by convention we'll name it "provision", but you can easily override that.
### Installation
1. Clone this repository (typically to the provision user `$HOME` directory)
2. Copy the install/example.vars.yml file to install/vars.yml
3. Amend the vars.yml file, and change the ansible_provision.username to your "provision" user.
4. Run the install playbook: ```ansible-playbook install/self-update.yml --extra-vars="@install/vars.yml" ```
Past this step, the vars.yml file can be safely deleted.

## Install with ansible-provision
If you already installed the stack, you can use it to provison other controllers machine. Obviously, you'll need at least one "manually installed" server to begin with.

## Install with Docker
@todo Docker image to come soon.

## Configuration
Past the initial setup, you will want to manage your configuration (hosts, etc) independantly.
To do so, amend the default that have been cloned in the "config" subdirectory, and
- point the git remote to the new location in which you want to manage your configuration
- make sure the ansible_provision.config_repository variable defaults to the same repository.
