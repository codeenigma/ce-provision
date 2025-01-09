# Base playbook for setting up a standalone EC2 instance.
IMPORTANT: these plays deliberately exclude the `_init._profile` variable because it needs to be set in the infra repo.

The `server.yml` file is the 'main' play but this needs to copied to the infra repo and renamed as `hostname.yml` e.g. `acme-dev1.yml`.  You also need to copy `provision.yml` so you can control what is provisioned. The `provision.yml` file is intended only as a model.

If you want a separate RDS instance to pair with your EC2 instance then uncomment the last two play import lines in `server.yml`, however note you do need to sort out outbound firewall ports in iptables and a Security Group for inbound traffic to the RDS instance - usually port `3306` outbound from the EC2 instance in `firewall_config` and an SG that allows `3306` inbound to RDS.

@TODO provide example infra repo for use with the AWS EC2 inventory plugin.
