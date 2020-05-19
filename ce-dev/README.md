# Helper stack for working locally on Ansible roles.

This will spin up some Docker containers to be able to run roles against.
By default, it will create:
- a "controller" container, which acts as the provisioning server. This "ansible-provision" repo is mounted at /home/ce-dev/ansible-provision, so all changes (to roles, etc) made from your host computer are directly available within the container
- an example "utility" server that can be targeted for provisioning, called **provision-controller**
- a blank target server, called **provision-target**

You can add more or amend those by defining them in the ce-dev.compose.yml file.

Each of the "targets" has a matching playbook in the ce-dev/ansible folder.

## Pre-requesites
You'll need https://github.com/codeenigma/ce-dev installed.

## Usage

Once you've reviewed the playbooks and uncommented the roles you needed (most are commented by default to speed up the process), you can spin up the project.

### 1. Generate the actual docker-compose file and start the containers
```ce-dev init && ce-dev start```

### 2. Provision the controller server
```ce-dev provision```

This needs to be done first, so the deploy user can be correctly populated and the controller server is setup.

### 3. Copy the hosts INI file

The _hosts_ file on the `provision-controller` container needs to managed manually and does not exist by default.

It can be copied from the `ce_dev_controller` container to your local:
```sudo docker cp ce_dev_controller:/home/ce-dev/ansible-provision/config/hosts/hosts .```

And then copied to the `provision-controller` container:
```sudo docker cp hosts provision-controller:/home/ce-dev/ansible-provision/config/hosts/```

### 4. Amend/create your roles, rince and repeat

When testing locally, you can put `is_local: yes` in the list of variables in your playbook. This will prevent certain roles from being installed, such as if you're including the **nginx** role, which has a dependency on the **aws/aws_cloudwatch_agent** role _except_ for when `is_local` is defined.

```ce-dev shell```

Select the `provision-controller` instance to connect to. From there, you can run a playbook to provision the provision-target server. There are two ways to run playbooks.
1. From the **~/ansible-provision** directory, run:
```ansible-playbook ce-dev/ansible/provision-target.yml```

1. Use the `provision.sh` wrapper script. As you're working locally, you can use the `--workspace` argument:
```/bin/sh /home/ce-dev/ansible-provision/scripts/provision.sh --repo unused --branch master --workspace /home/ce-dev/ansible-provision --playbook ce-dev/ansible/provision-target.yml```

    The `--repo` and `--branch` arguments are still mandatory, but they won't be used because you're passing in the `--workspace` argument as well, so you can pass through any value for those two arguments. The `--workspace` and `--playbook` arguments **must** create an absolute path to the playbook that you want to run.
