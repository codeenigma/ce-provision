# Gitlab Runner
Install the Gitlab Runner binary from .deb package.
<!--TOC-->
<!--ENDTOC-->

The role installs the gitlab-runner package on the target server and installs a default built in shell runner, though you will need to create the registration token for the runner and add it to your variables. You can define one or more runners as a list of dicts as shown below. You can also set `gitlab_runner.runners` to an empty list if you do not want to override the default config shipped with the Debian package.

If you want to use AWS ECS with Fargate for orchestrating CI containers then set `install_fargate: true` in your variables to install the driver and set your AWS variables in the `fargate` dict.

<!--ROLEVARS-->
## Default variables
```yaml
---
gitlab_runner:
  apt_origin: "origin=packages.gitlab.com/runner/gitlab-runner,codename=${distro_codename},label=gitlab-runner" # used by apt_unattended_upgrades
  apt_signed_by: https://packages.gitlab.com/runner/gitlab-runner/gpgkey
  concurrent_jobs: 10
  check_interval: 0
  session_timeout: 1800
  runners:
    # Default built-in shell executor runner
    - output_limit: 30000
      name: "Default runner"
      url: "https://gitlab.example.com"
      token: "" # see https://docs.gitlab.com/runner/register/
      executor: "shell"
    # Example custom executor runner (ECS Fargate)
    #- output_limit: 30000
    #  name: "Fargate runner"
    #  url: "https://gitlab.example.com"
    #  token: ""
    #  executor: "custom"
    #  builds_dir: "/opt/gitlab-runner/builds"
    #  cache_dir: "/opt/gitlab-runner/cache"
    #  config_exec: "/opt/gitlab-runner/fargate"
    #  config_args: '["--config", "/etc/gitlab-runner/fargate.toml", "custom", "config"]'
    #  prepare_exec: "/opt/gitlab-runner/fargate"
    #  prepare_args: '["--config", "/etc/gitlab-runner/fargate.toml", "custom", "prepare"]'
    #  run_exec: "/opt/gitlab-runner/fargate"
    #  run_args: '["--config", "/etc/gitlab-runner/fargate.toml", "custom", "run"]'
    #  cleanup_exec: "/opt/gitlab-runner/fargate"
    #  cleanup_args: '["--config", "/etc/gitlab-runner/fargate.toml", "custom", "cleanup"]'
  install_fargate: false
  restart: true # set to false if you're applying settings to a server responsible for its own runners
  username: "{{ ce_deploy.username }}"
  docker_group: "docker"
  runner_workingdir: "/home/{{ ce_deploy.username }}/build"
  runner_config: "/etc/gitlab-runner/config.toml"
  # see https://gitlab.com/gitlab-org/ci-cd/custom-executor-drivers/fargate/-/tree/master/docs
  fargate:
    cluster: "my-cluster" # ECS cluster name
    profile: "example" # AWS boto profile name - can be substituted for "{{ _aws_profile }}" if set
    region: "eu-west-1" # AWS region name - can be substituted for "{{ _aws_region }}" if set
    subnet: "subnet-abcdef123456" # subnet ID
    security_group: "my-security-group" # SG name
    task_definition: "my-task:1" # task definition in format name:revision, if revision is not provided ECS will use latest
    public_ip: "false" # if your containers need a public IP assigning
    version: "1.4.0" # Fargate platform version
    metadata_dir: "/opt/gitlab-runner/metadata"
    ssh_user: "root"
    ssh_port: 22

```

<!--ENDROLEVARS-->
