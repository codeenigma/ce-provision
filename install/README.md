# Install
The simplest way to install is using the installation script provided in the root of this repository, `install.sh`.

## Install manually
### Dependencies
The stack has been created on Debian Linux. The 1.x branch is for Debian Buster (10) and the 2.x branch is for Debian Bullseye (11) and Bookworm (12). It might run on other Debian versions or derivatives, but this is untested.

The main prerequesites are obviously Ansible and git. Depending on how you setup your inventory, you might need some other Python libraries (e.g. Boto3 for AWS).
You will also need a local user to install locally, by convention we'll name it `controller`, but you can override that.

### Installation
Download [the `install.sh` file](https://raw.githubusercontent.com/codeenigma/ce-provision/devel-2.x/install.sh) on to the target server and make it executable, then run it - for example:

```sh
curl -LO https://raw.githubusercontent.com/codeenigma/ce-provision/devel-2.x/install.sh
chmod +x ./install.sh
sudo ./install.sh -h # for usage information
# Default installation (ce-provision only)
sudo ./install.sh
# Installation with GitLab CE using a self-signed SSL certificate
sudo ./install.sh --gitlab gitlab.example.com
# Installation with GitLab CE using a LetsEncrypt SSL certificate (requires DNS to be set up in advance)
sudo ./install.sh --letsencrypt --gitlab gitlab.example.com
```

## Install with ce-provision
If you already installed the stack, you can use it to provison other controller machines by using the `_meta/controller` role.

## Configuration
Past the initial setup, you will want to manage your configuration (hosts, etc.) independently. The script above will have installed `ce-provision` with our "example" config repository into the `config` subdirectory. You can amend the defaults there and:
* alter the git remote settings to a new location in which you want to manage your configuration
* update the `ce_provision.config_repository` variable accordingly so future builds use your config repo instead of the example one

## Roadmap
Docker support is planned for the future.
