# Firewall Config
This role provides a wrapper for [Jeff Geerling's Ansible firewall role for iptables](https://github.com/geerlingguy/ansible-role-firewall/).

Note, it explicitly does not state that dependency in `meta` because in some cases `iptables` needs installing from `buster-backports` and that cannot work if Ansible tries to install it as a dependency. This is why the first task in this role is installing `iptables` from `buster-backports` if the `is_local` variable is set (e.g we are in a [ce-dev](https://github.com/codeenigma/ce-dev/) container).

<!--TOC-->
<!--ENDTOC-->

## Usage
The role has a concept of `rulesets` which take the form of a set of lists of firewall rules to apply. We ship some standard `rulesets`, such as this one called `web_open`:

```yaml
---
firewall_config:
  firewall_allowed_tcp_ports:
    web_open:
      - "80"
      - "443"

```

The variable filename is the `ruleset` name as defined in `firewall_config.rulesets` and the key name for each list of firewall rules must match the filename, in the above example it's `webopen`.

As long as your ruleset is in a path Ansible will load variables from and follows a structure like that it will be loaded and applied if called in the variables for a given server or group of servers.

See the main firewall role for available options: https://github.com/geerlingguy/ansible-role-firewall/blob/master/defaults/main.yml#L7

<!--ROLEVARS-->
## Default variables
```yaml
---
firewall_config:
  rulesets:
    - web_open
    - ssh_open

```
<!--ENDROLEVARS-->
