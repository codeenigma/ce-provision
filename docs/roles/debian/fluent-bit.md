# Fluent-bit

## Description

Deploy [Fluent-bit](https://github.com/fluent/fluent-bit) using ansible.

### Requirements

Role expects to be provided with the following information:
* `fluentbit_main_config` - the main Fluent-bit configuration

### Example
Minimum Fluent-bit config that will send a test log, filter it, and output to stdout.

```yaml
fluentbit_main_config:
  service:
    flush: 5
    log_level: info

parsers:
    - name: json
      format: json
      time_key: time
      time_format: '%d/%b/%Y:%H:%M:%S %z'

  pipeline:
    inputs:
        - name: dummy
          dummy: '{"endpoint":"localhost", "value":"something"}'
          tag: dummy
    filters:
        - name: grep
          match: '*'
          logical_op: or
          regex:
            - value something
            - value error
    outputs:
        - name: stdout

```

For more details on setting up the Fluent-bit config, refer to official documentation:
https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bitexporter

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
---
# Default variables for Fluent-bit role
fluent_bit_repo_key_url: https://packages.fluentbit.io/fluentbit.key
fluent_bit_key_location: /usr/share/keyrings/fluentbit-keyring.asc
fluent_bit_apt_source: "deb [signed-by=/usr/share/keyrings/fluentbit-keyring.asc] https://packages.fluentbit.io/debian/{{ ansible_distribution_release }} {{ ansible_distribution_release }} main"
fluent_bit_startup_command: /opt/fluent-bit/bin/fluent-bit -c /etc/fluent-bit/fluent-bit.yml

fluent_bit_configuration: ""

```

<!--ENDROLEVARS-->
