# YACE

## Description

Deploy [YACE - yet another cloudwatch exporter](https://github.com/prometheus-community/yet-another-cloudwatch-exporter) using ansible.

### Requirements

Role expects to be provided with the following information:
* `yace_exporter_configuration` - the actual YACE configuration
* `yace_exporter_iam_configuration` - a JSON formatted IAM policy

### Example
Minimum YACE config that will fetch EC2 CPU usage, with a minimum IAM policy required for that.

```yaml
yace_exporter_configuration:
  apiVersion: v1alpha1
  discovery:
    jobs:
      - type: AWS/EC2
        regions:
          - eu-west-1
        metrics:
          - name: CPUUtilization
            statistics:
              - Average
            period: 300
            length: 300
```

```yaml
  yace_exporter_iam_configuration: |
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": [
                  "tag:GetResources",
                  "cloudwatch:GetMetricData",
                  "cloudwatch:GetMetricStatistics",
                  "cloudwatch:ListMetrics",
                  "ec2:DescribeSpotFleetRequests"
              ],
              "Effect": "Allow",
              "Resource": "*"
          }
      ]
  }
  ```

For more details on setting up the YACE exporter config, refer to:
https://github.com/prometheus-community/yet-another-cloudwatch-exporter

<!--TOC-->
<!--ENDTOC-->

<!--ROLEVARS-->
<!--ENDROLEVARS-->
