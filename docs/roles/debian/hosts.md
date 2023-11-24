# Managed /etc/hosts
Forked from https://github.com/bertvv/ansible-role-hosts

<!--TOC-->
<!--ENDTOC-->


<!--ROLEVARS-->
## Default variables
```yaml
---
hosts_hostname: "" # provide a hostname to manage the system hostname value.

hosts_playbook_version: "1.0.1"

# If set to true, an entry for `ansible_hostname`, bound to the host's default IPv4 address is added added.
hosts_add_default_ipv4: true

# If set to true, basic IPv6 entries (localhost6, ip6-localnet, etc) are added.
hosts_add_basic_ipv6: true

# If set to true, an entry for every host managed by Ansible is added. Remark that this makes `hosts_add_default_ipv4` unnecessary, as it will be added as wel by this setting.
hosts_add_ansible_managed_hosts: false

# Default hosts entries; controlled in config repo
_default_hosts_entries: []

# Custom hosts entries to be added
hosts_entries: []
# hosts_entries:
#   - name: example.com
#     ip: 123.123.123.123
#     aliases:
#       - example.net
#       - example.org
#       - example

# Custom host file snippets to be added
hosts_file_snippets: []

# IP protocol to use
hosts_ip_protocol: "ipv4"

# Network interface to use
hosts_network_interface: "{{ ansible_default_ipv4.interface }}"

# Backup of previous host
host_file_backup: false

```

<!--ENDROLEVARS-->
