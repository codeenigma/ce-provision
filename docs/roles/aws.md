# AWS Infrastructure
These roles help you manage assets in AWS. Because these roles are AWS specific, you should not try to use them in a non-AWS environment. There are also some quite specific variables we expect to exist, specifically:

* `_aws_region`
* `_aws_profile`
* `_aws_resource_name`

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
<!--ENDROLEVARS-->

## Hosts and groups handling
These roles assume you use the AWS EC2 inventory plugin to automatically build inventory:
* https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html

This can be loaded via your `ansible.cfg` file in your config repository.

You should place a file called `aws_ec2.yml` in the `hosts` directory of your config repository. Our standard file looks like this:

```yaml
plugin: amazon.aws.aws_ec2
filters:
  tag:Ansible: managed
keyed_groups:
  - key: tags.Name
    prefix: ""
  - key: tags.Env
    prefix: ""
  - key: tags.Profile
    prefix: ""
  - key: tags.Infra
    prefix: ""
```

### How it works
The plugin is loading all EC2 instances that are tagged with `Ansible: managed` and then grouping them by the tags `Name`, `Env`, `Profile` and `Infra`. Any hyphens in tags are automatically converted to underscores, and the prefixing convention is taken from the default behaviour of the `ansible.builtin.constructed` plugin, which you can read here - note specifically the `leading_separator` parameter and its documentation:
* https://docs.ansible.com/ansible/latest/collections/ansible/builtin/constructed_inventory.html#parameter-leading_separator

Consequently, because we group all infra by the `Name` tag, effectively our inventory will always contain a group consisting of the name of that machine, prefixed with an underscore, for example the server named `web1-example-com` would end up in a group of one instance like this:

```
  |--@_web1_example_com:
  |  |--ec2-1-112-233-9.eu-west-1.compute.amazonaws.com
```

In this way we can act on a specific host or group of hosts by invoking its unique group, for example you can use a line like this at the top of your infrastructure plays to load the target(s) using a group name:

```yaml
- hosts: "_{{ _aws_resource_name | regex_replace('-', '_') }}"
  become: true
```

### Debugging and viewing hosts
You can view the graphed *default* infrastructure from the command line of a controller with a command like this when logged in as the `ce-provision` user, usually `controller`:

```
ansible-inventory -i ~/ce-provision/hosts/aws_ec2.yml --graph
```

If you wanted to see the inventory for another boto profile you need to set the `AWS_PROFILE` environment variable. For example, this would graph the `acme` profile's inventory:

```
AWS_PROFILE=acme ansible-inventory -i ~/ce-provision/hosts/aws_ec2.yml --graph
```

You will note there are other groupings, for example you can call all the `_prod` infrastructure because there is also a grouping against the `Env` tag, or you can call all the `_web` servers because they are also grouped by `Profile`, and so on.

### Unmanaged infra
If you want a host that is not tagged with `Ansible: managed` in AWS, or indeed not in AWS at all, to be "known" to Ansible you need to add it to `hosts.yml` in your config repo.

### Using group_vars
Once you understand this, the `group_vars` directory within your config repository starts to make sense. You can set variables that apply to any group that gets created automatically by the inventory plugin, for example, if you have a test infrastructure called `test` you can have a `hosts/group_vars/_test` folder containing variables which will apply to *every single server* in the `test` infra and take precedence over the defaults, which you can define in `hosts/group_vars/all`. Similarly we might have a `_production` folder containing variables for every server tagged in a `production` environment, regardless of infra.

You can play with tags in your plugin config to create the combinations and groupings you need.
