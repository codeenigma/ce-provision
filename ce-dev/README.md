# Helper stack for working locally on Ansible roles.

This will spin up some Docker containers to be able to run roles against.
By default, it will create:

- a "controller" container, which acts as the provisioning server. This "ce-provision" repo is mounted at /home/ce-dev/ce-provision, so all changes (to roles, etc) made from your host computer are directly available within the container
- a blank target server, called **provision-target**, which has standard privileges and should be used for most usecases.
- another blank target server, called **provision-privileged**, that runs as a privileged container. This is needed for eg the gitlab role.

## Pre-requesites

You'll need https://github.com/codeenigma/ce-dev installed.

You'll need to set up a `config` directory in the root of the cloned `ce-provision` project, the deploy playbooks expect it to exist and to have `ansible.cfg` within. If you already have a private config repo for your organisation that should be cloned here. If you do not, you can use our provided example repo to get started with - https://github.com/codeenigma/ce-provision-config-example

## Usage

### 1. Generate the actual docker-compose file and start the containers

`ce-dev init && ce-dev start`

### 2. Provision the controller server

`ce-dev provision`

This needs to be done first, so the deploy user can be correctly populated and the controller server is setup.

### 3. Amend the git remote(s)

The setup step uses the standard repo path, https://github.com/codeenigma/ce-provision.git which is not suitable for pushing/MR.
You need to manually amend it to use the ssh version (or point it to your private fork).

```
git remote remove origin
git remote add origin git@github.com:codeenigma/ce-provision.git
```

### 4. Create your playbook(s)

You can start creating playbooks in the ce-dev/ansible/local directory which is .gitignored (copy them from the examples folder).

When testing locally, you can put `is_local: true` in the list of variables in your playbook. This will prevent certain roles from being installed, such as if you're including the **nginx** role, which has a dependency on the **aws/aws_cloudwatch_agent** role _except_ for when `is_local` is defined.

Or you can include the 'common.yml' vars file, as it will set all the needed variables to be able to work locally and call ansible-playbook directly without going through the wrapper script (see below).

### 5. Ensure your hosts are properly configured

If you run step 6 without hosts configured you will get a `skipping: no hosts matched` message and nothing will happen. There needs to be a `hosts` or `hosts.yml` file in your config directory, which is fetched during the Pre-requesites step above, for example:

* https://github.com/codeenigma/ce-provision-config-example/blob/master/hosts/hosts.yml

You need to ensure this exists and the correct IP addresses are defined (you can check this with `ping` or by looking at the `/etc/hosts` file on the host machine). Note, other formats are also valid. See the docs for details:

* https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html

### 6. Run, amend/create your roles, rince and repeat

`ce-dev shell`

Select the `provision-controller` instance to connect to. From there, you can run a playbook to provision the provision-target server. But first you will need to create your playbooks and vars, these are deliberately excluded because they will necessarily change with what you are testing, but instructions and examples can be found in `ce-dev/ansible/plays/provision-target/README.md`. 

Once that's done, there are two ways to run playbooks:

1.  From the **~/ce-provision** directory, run:
    `ansible-playbook ce-dev/ansible/plays/provision-target/provision-target.yml`

2.  Use the `provision.sh` wrapper script. As you're working locally, you can use the `--workspace` argument:
    `/bin/sh /home/ce-dev/ce-provision/scripts/provision.sh --repo unused --branch master --workspace /home/ce-dev/ce-provision --playbook ce-dev/ansible/plays/provision-target/provision-target.yml`

        The `--repo` and `--branch` arguments are still mandatory, but they won't be used because you're passing in the `--workspace` argument as well, so you can pass through any value for those two arguments. The `--workspace` and `--playbook` arguments **must** create an absolute path to the playbook that you want to run.
