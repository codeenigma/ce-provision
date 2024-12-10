# AWS SG/firewall role
This role is used to define and set rules for SG and iptables so we have matching open ports on both ends

When this role is included in provision.yml it will override "_global_security_groups" and "firewall_config" rules and definitions
If we use the same name as existing SG it will just attach it's rules on top of current ones, to purge them either remove or set following 2 vars to true:

purge_rules
purge_rules_egress

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
aws_sg_iptables:
  - description: Test rule for new role
    name: Test rule
    rules:
    - cidr_ip: 0.0.0.0/0
      from_port: 8
      proto: icmp
      rule_desc: Allow ICMP IPv4 ping
      to_port: -1
      priority: 1  # Priority will be used to set rules in order (Highest priority will become first rule)
    - cidr_ipv6: ::/0
      from_port: 128
      proto: icmp
      rule_desc: Allow ICMP IPv6 ping
      to_port: -1
      priority: 5
    - cidr_ip: 0.0.0.0/0
      ports:
      - 22
      proto: tcp
      rule_desc: Allow all tcp traffic on SSH
      priority: 4
    - cidr_ip: 0.0.0.0/0
      ports:
      - 80
      proto: tcp
      rule_desc: Allow all tcp traffic on HTTP
      priority: 3
    - cidr_ip: 0.0.0.0/0
      ports:
      - 443
      proto: tcp
      rule_desc: Allow all tcp traffic on HTTPS
      priority: 2
    rules_egress:
    - cidr_ip: 0.0.0.0/0
      ports:
      - 1-1024
      - 2049
      proto: tcp
      rule_desc: Allow ports 1-1024 and 2049 for NFS as standard
      priority: 1

```

<!--ENDROLEVARS-->
