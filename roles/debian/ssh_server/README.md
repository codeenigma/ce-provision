# SSHD

<!--TOC-->
<!--ENDTOC-->


<!--ROLEVARS-->
## Default variables
```yaml
---
sshd:
  # Main options.
  Port:
    - 22
  ListenAddress:
    - "0.0.0.0"
    - "::"
  AllowAgentForwarding: "yes"
  AllowGroups: ""
  AllowTcpForwarding: "yes"
  AuthenticationMethods: ""
  AuthorizedKeysCommand: ""
  AuthorizedKeysCommandUser: "nobody"
  ChallengeResponseAuthentication: "no"
  ClientAliveCountMax: 3
  ClientAliveInterval: 60
  Compression: "delayed"
  GatewayPorts: "no"
  HostKey: []
  LoginGraceTime: "2m"
  LogLevel: "INFO"
  MaxAuthTries: 6
  MaxSessions: 10
  PasswordAuthentication: "no"
  PermitRootLogin: "prohibit-password"
  PermitTTY: "yes"
  PermitTunnel: "no"
  PermitUserEnvironment: "no"
  PrintLastLog: "yes"
  PrintMotd: "no"
  Protocol: "2"
  PubkeyAuthentication: "yes"
  RekeyLimit: "default none"
  StrictModes: "yes"
  Subsystem_sftp: "internal-sftp"
  SyslogFacility: "AUTH"
  TCPKeepAlive: "yes"
  UseDNS: "no"
  UsePAM: "yes"
  X11DisplayOffset: 10
  X11Forwarding: "yes"
  X11UseLocalhost: "yes"
  # Define some defaults "special" groups.
  groups: []
  # groups:
  #   # Define a group that is allowed to use password authentication.
  #   - name: passwordonly
  #     settings:
  #       PasswordAuthentication: "yes"
  #   # Define a group that is allowed to use password authentication and restricted to SFTP use.
  #   - name: sftpusers
  #     settings:
  #       PasswordAuthentication: "yes"
  #       AuthenticationMethods: "password"
  #       ChrootDirectory: "%h/documents"
  #       X11Forwarding: "no"
  #       AllowTcpForwarding: "no"
  #       ForceCommand: "internal-sftp"
  users: []
  # users:
  #   # Allow users to use key only.
  #   - names:
  #       - example1
  #       - user4
  #       - another
  #     settings:
  #       PasswordAuthentication: "no"
  #       AuthenticationMethods: publickey

```

<!--ENDROLEVARS-->
