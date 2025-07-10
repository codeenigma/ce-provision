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
## Default variables
```yaml
---
# Default variables for YACE Exporter role
yace_exporter_version: "0.62.1"  # Adjust as needed
# Construct the download URL using the version variable.
yace_exporter_download_url: "https://github.com/prometheus-community/yet-another-cloudwatch-exporter/releases/download/v{{ yace_exporter_version }}/yet-another-cloudwatch-exporter-{{ yace_exporter_version }}.linux-amd64.tar.gz"

# Directories and file locations
yace_exporter_install_dir: "/usr/local/bin"
yace_exporter_system_user: "yace-exporter"
yace_exporter_system_group: "yace-exporter"
# Service runtime options
yace_exporter_listen_address: "0.0.0.0:9105"
yace_exporter_service_name: "yace_exporter"

# YACE configuration
yace_exporter_configuration: {}
# Example config
# yace_exporter_configuration:
#  apiVersion: v1alpha1
#  discovery:
#    jobs:
#      - type: AWS/EC2
#        roles:
#          - roleArn: "arn:aws:iam::$ACCOUNT_ID:role/YaceExporterRole"
#        regions:
#          - eu-west-1
#        metrics:
#          - name: CPUUtilization
#            statistics:
#              - Average
#            period: 300
#            length: 300
#      - type: AWS/RDS
#        roles:
#          - roleArn: "arn:aws:iam::$ACCOUNT_ID:role/YaceExporterRole"
#        regions:
#          - eu-west-1
#        searchTags:
#          - key: Ansible
#            value: managed
#        metrics:
#          - name: CPUUtilization
#            statistics:
#              - Average
#            period: 300
#            length: 300
#          - name: DatabaseConnections
#            statistics:
#              - Average
#              - Sum
#            period: 300
#            length: 300
#        dimensionNameRequirements:
#          - DBInstanceIdentifier

 # Server IAM policy to allow YACE service to pull metrics
yace_exporter_iam_configuration: {}
# Example iam config that grants full permissions
# yace_exporter_iam_configuration: |
#  {
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#        "Action": [
#          "tag:GetResources",
#          "cloudwatch:GetMetricData",
#          "cloudwatch:GetMetricStatistics",
#          "cloudwatch:ListMetrics",
#          "apigateway:GET",
#          "aps:ListWorkspaces",
#          "autoscaling:DescribeAutoScalingGroups",
#          "dms:DescribeReplicationInstances",
#          "dms:DescribeReplicationTasks",
#          "ec2:DescribeTransitGatewayAttachments",
#          "ec2:DescribeSpotFleetRequests",
#          "shield:ListProtections",
#          "storagegateway:ListGateways",
#          "storagegateway:ListTagsForResource",
#          "iam:ListAccountAliases"
#        ],
#        "Effect": "Allow",
#        "Resource": "*"
#      }
#    ]
#  }

```

<!--ENDROLEVARS-->
