# Base playbook to configure a new target server
This playbook configures a new target server, and should just work if you have followed the installation and configuration instructions [in our GitHub wiki](https://github.com/codeenigma/ce-provision/wiki/Installation). It will add the server to `hosts` in your config repository and install Ansible dependencies and the controller user on the target host. Once this is done you can orchestrate its future configuration with ce-provision.

## Prerequisites
* You have followed the official installation instructions for your controller
* Your new target server has the controller's SSH public key assigned to a Linux user
* Your new target server has port 22 open to the controller
* Your Ansible `hosts` inventory file has `ansible_connection=local` set for your controller at `localhost`

## Usage
On your controller server:

```shell
sudo su -l controller
cd /home/controller/ce-provision && \
  ./scripts/provision.sh \
  --workspace /home/controller/ce-provision \
  --repo none --branch none \
  --playbook plays/launcher/configure.yml \
  --ansible-extra-vars "_provision_host=1.2.3.4 _target_username=admin" \
  --force
```

Change the value of `1.2.3.4` on the last line to match your IP address or hostname. Change the value of `admin` to whatever the Linux username is installed by default with your SSH public key attached. This may vary, see your provider's documentation for details.
