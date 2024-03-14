# Firewall Config
This role provides a wrapper for [Jeff Geerling's Ansible firewall role for iptables](https://github.com/geerlingguy/ansible-role-firewall/).

Note, it explicitly does not state that dependency in `meta` because in some cases `iptables` needs installing from `buster-backports` and that cannot work if Ansible tries to install it as a dependency. This is why the first task in this role is installing `iptables` from `buster-backports` if the `is_local` variable is set (e.g we are in a [ce-dev](https://github.com/codeenigma/ce-dev/) container).

<!--TOC-->
<!--ENDTOC-->

## Usage
The role has a concept of `rulesets` which take the form of a set of lists of firewall rules to apply. We ship some standard `rulesets`, such as this one called `web_open` which opens TCP ports 80 and 443:

```yaml
firewall_config:
  web_open:
    firewall_allowed_tcp_ports:
      - "80"
      - "443"

```

See the main firewall role for available options and usage: https://github.com/geerlingguy/ansible-role-firewall/blob/master/defaults/main.yml#L7

Your `firewall_config` rulesets can be loaded in from anywhere Ansible will load variables, so modules can invoke this role directly and set their own rulesets in their variables files. To work through an example, if I wanted to have a list of restricted IPs for SSH on a web server, I could make a custom ruleset like this in a file in `config/hosts/group_vars/all`:

```yaml
firewall_config:
  ssh_restricted:
    firewall_additional_rules:
      - "iptables -A INPUT -p tcp --dport 22 -s 1.0.0.1 -j ACCEPT" # old vpn
      - "iptables -A INPUT -p tcp --dport 22 -s 1.1.1.1 -j ACCEPT" # vpn
      - "iptables -A INPUT -p tcp --dport 22 -s 8.8.8.8 -j ACCEPT" # infra1

```

Then in my variables for the web server I can set `rulesets` like this:

```yaml
firewall_config:
  rulesets:
    - ssh_restricted
    - web_open
```

So Ansible will apply my custom `ssh_restricted` ruleset and the built-in `web_open` ruleset.

<!--ROLEVARS-->
## Default variables
```yaml
---
firewall_config:
  # Because firewall.bash isn't overwritten once it exists we need to delete it to apply rule changes.
  purge: true
  # General settings
  # See https://github.com/geerlingguy/ansible-role-firewall/blob/master/defaults/main.yml
  firewall_state: started
  firewall_enabled_at_boot: true
  firewall_enable_ipv6: false
  firewall_log_dropped_packets: true
  firewall_disable_ufw: true
  firewall_allowed_tcp_ports: [ "22" ] # initially open port 22 so we don't lose connection
  rulesets:
    - ssh_open
    - web_open

  # Ruleset definitions
  # Permitted rule lists
  # firewall_allowed_tcp_ports
  # firewall_allowed_udp_ports
  # firewall_forwarded_tcp_ports
  # firewall_forwarded_udp_ports
  # firewall_additional_rules
  # firewall_ip6_additional_rules
  ssh_open:
    firewall_allowed_tcp_ports:
      - "22"
  web_open:
    firewall_allowed_tcp_ports:
      - "80"
      - "443"
  mailpit_open:
    firewall_allowed_tcp_ports:
      - "8025"
  ftp_open:
    firewall_allowed_tcp_ports:
      - "20"
      - "21"
  sftp_open:
    firewall_allowed_tcp_ports:
      - "989"
      - "990"
  letsencrypt:
    firewall_allowed_tcp_ports:
      - "80"
  ossec:
    firewall_allowed_udp_ports:
      - "1514"
      - "1515"
  openvpn:
    firewall_allowed_udp_ports:
      - "1194"
    firewall_additional_rules:
      - "echo 1 > /proc/sys/net/ipv4/ip_forward" # Enable forwarding of IP
      - "iptables -A INPUT -s 10.8.0.0/24 -i tun0 -j ACCEPT" # Accept traffic from the VPN on all interfaces - change this if you change openvpn_config default addresses
      - "iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT" # Forward traffic from the VPN interface out via eth0
      - "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" # Replace the source IP with the eth0 public IP when forwarding outbound

```

<!--ENDROLEVARS-->
