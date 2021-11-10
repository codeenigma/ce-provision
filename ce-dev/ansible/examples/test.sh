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
}

# Set defaults
EXAMPLES="blank gitlab"
OWN_BRANCH="1.x"
CONFIG_BRANCH="1.x"

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
  $CE_DEV_BIN init
  $CE_DEV_BIN destroy
  $CE_DEV_BIN start
  $CE_DEV_BIN provision
}

# Build an example.
# @param $1
# Example name.
# @param $2
# ce-provision branch to check out.
# @param $3
# ce-provision config repo branch to check out.
build_example(){
  cd config
  git fetch
  cd ..
  git fetch
  PROVISION_CMD="/bin/sh /home/ce-dev/ce-provision/scripts/provision.sh"
  PROVISION_CMD="$PROVISION_CMD --repo dummy --branch dummy --workspace /home/ce-dev/ce-provision/ce-dev/ansible --playbook examples/$1/$1.yml --own-branch $2 --config-branch $3"
  # shellcheck disable=SC2086
  sudo docker exec -t --workdir /home/ce-dev/ce-provision --user ce-dev provision-controller $PROVISION_CMD
}

init_ce_dev

for EXAMPLE in $EXAMPLES; do
  build_example "$EXAMPLE" "$OWN_BRANCH" "$CONFIG_BRANCH"
done