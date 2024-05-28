#!/bin/sh
# Test project creation and templates.
set -e

usage(){
  echo 'test.sh [OPTIONS]'
  echo 'Tests project creation and templates.'
  echo ''
  echo 'Available options:'
  echo '--examples: Space separated string of templates to test - defaults to "blank gitlab".'
  echo '--own-branch: Branch to use for the main stack repository'
  echo '--config-branch: Branch to use for the main stack config repository'
  echo '--no-rebuild: Do not tear down an existing ce-dev stack'
  echo '--no-provision: Do not run ce-provision against the ce-dev stack'
  echo '--verbose: Run ce-provision and Ansible in verbose mode'
}

# Set defaults
EXAMPLES="blank gitlab"
OWN_BRANCH="2.x"
CONFIG_BRANCH="2.x"
NO_REBUILD=false
NO_PROVISION=false
VERBOSE=false

# Parse options arguments.
parse_options(){
  while [ "${1:-}" ]; do
    case "$1" in
      "--examples")
          shift
          EXAMPLES="$1"
        ;;
      "--own-branch")
          shift
          OWN_BRANCH="$1"
        ;;
      "--config-branch")
          shift
          CONFIG_BRANCH="$1"
        ;;
      "--no-rebuild")
          NO_REBUILD=true
        ;;
      "--no-provision")
          NO_PROVISION=true
        ;;
      "--verbose")
          VERBOSE=true
        ;;
        *)
        usage
        exit 1
        ;;
    esac
    shift
  done
}

# Parse options.
parse_options "$@"

# ce-dev "binary"
CE_DEV_BIN="/usr/local/bin/ce-dev"

# Init/reset environment.
init_ce_dev(){
  echo "# Configuring ce-dev"
  $CE_DEV_BIN init
  $CE_DEV_BIN destroy
  $CE_DEV_BIN start
}

# Build an example.
# @param $1
# Example name.
# @param $2
# ce-provision branch to check out.
# @param $3
# ce-provision config repo branch to check out.
build_example(){
  echo "# Switching to config directory"
  cd config
  echo "# Fetching git origin for config"
  git fetch origin
  echo "# Switching to root directory"
  cd ..
  echo "# Fetching git origin for ce-provision"
  git fetch origin
  echo "# Adding local hosts entries to container"
  cat <<EOT >> config/hosts/hosts
provision-controller
provision-target
provision-privileged
EOT
  PROVISION_CMD="/bin/sh /home/ce-dev/ce-provision/scripts/provision.sh"
  echo "# Executing $1 project"
  PROVISION_CMD="$PROVISION_CMD --repo dummy --branch dummy --workspace /home/ce-dev/ce-provision/ce-dev/ansible --playbook plays/$1/$1.yml --own-branch $2 --config-branch $3 --force"
  if [ $VERBOSE = true ]; then
    echo "# In verbose mode"
    PROVISION_CMD="$PROVISION_CMD --verbose"
  fi
  echo "# Running command: $PROVISION_CMD"
  # shellcheck disable=SC2086
  sudo docker exec -t --workdir /home/ce-dev/ce-provision --user ce-dev provision-controller $PROVISION_CMD
  echo "### $1 project completed ###"
}

if [ $NO_REBUILD = false ]; then
  init_ce_dev
fi

if [ $NO_PROVISION = false ]; then
  echo "# Configuring container with ce-provision"
  $CE_DEV_BIN provision
fi

echo "# Building example projects"
for EXAMPLE in $EXAMPLES; do
  build_example "$EXAMPLE" "$OWN_BRANCH" "$CONFIG_BRANCH"
done
