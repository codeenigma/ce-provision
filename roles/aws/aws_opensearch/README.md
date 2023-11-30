# AWS OpenSearch
Creates an OpenSearch or Elasticsearch domain using the [AWS OpenSearch Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html).

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
## Default variables
```yaml
aws_opensearch:
  aws_profile: "{{ _aws_profile }}"
  aws_region: "{{ _aws_region }}"
  domain_name: example
  tags: {}
  engine_version: OpenSearch_2.5 # e.g. OpenSearch_1.0 or Elasticsearch_6.8
  instance_type: t3.medium.search
  instance_count: 1
  zone_awareness: false
  dedicated_master: false
  availability_zone_count: 1
  warm_enabled: false
  cold_storage: false
  volume_type: "gp2"
  volume_size: 10
  subnets:
    - "subnet-aaaaaaaa"
    - "subnet-bbbbbbbb"
  security_groups: [] # list of security group names, converted to IDs by aws_security_groups role
  automated_snapshot_start_hour: 3
  auto_tune: "DISABLED" # not supported when t3's are used
  # List of maintenance schedules to use if auto_tune is set to "ENABLED":
  #auto_tune_maintenance_schedules:
  #  - start_at: "2022-08-10"
  #    duration:
  #      value: 2
  #      unit: "HOURS"
  #    cron_expression_for_recurrence: "cron(0 2 * * *)"

```

<!--ENDROLEVARS-->
