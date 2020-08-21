# Usage
While you can re-use/fork roles or call playbooks directly from your deployment tool, it is recommended to use the provided wrapper script, as it will take care of setting up the needed environments variables.
### Arguments
You will need to pass at least the following information:
- --repo: the git repo containing the codebase to deploy, alongside the deploy playbook to play
- --branch: the branch to checkout for the given repo
- --playbook: the path to the playbook to play, relative to the root of the repository to deploy
### Steps
What this will do is:
- clone the given repository locally on the "controller" server;
- call ansible-playbook
### Example
This how you'd call the provision.sh script from Jenkins:
```
/home/deploy/ce-provision/scripts/provision.sh --repo "git@gitlab.com:example/myproject.git" --branch "dev" --playbook "myserver/server2.yml"
```
