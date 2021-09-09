# Firewall Config
This role provides a wrapper for [Jeff Geerling's Ansible firewall role for iptables](https://github.com/geerlingguy/ansible-role-firewall/).

Note, it explicitly does not state that dependency in `meta` because in some cases `iptables` needs installing from `buster-backports` and that cannot work if Ansible tries to install it as a dependency. This is why the first task in this role is installing `iptables` from `buster-backports` if the `is_local` variable is set (e.g we are in a [ce-dev](https://github.com/codeenigma/ce-dev/) container).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
<!--ENDROLEVARS-->
