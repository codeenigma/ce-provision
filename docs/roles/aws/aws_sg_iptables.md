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
  - description: Security group for open ssh and icmp
    name: ssh-icmp-open
    purge_rules: false # Set this to true to override existing incoming rules for SG with same name
    purge_rules_egress: false # Set this to true to override existing outgoing rules for SG with same name
    rules:
    - cidr_ip: 0.0.0.0/0
      from_port: 8
      proto: icmp
      rule_desc: Allow ICMP IPv4 ping
      to_port: -1
    - cidr_ip: 0.0.0.0/16
      ports:
      - 22
      proto: tcp
      rule_desc: Allow all tcp traffic on port 22
    rules_egress:
    - cidr_ip: 0.0.0.0/0
      ports:
      - 1-1024
      - 2049
      proto: tcp
      rule_desc: Allow ports 1-1024 and 2049 for NFS as standard

```

<!--ENDROLEVARS-->
