#!/bin/sh
# Test project creation and templates.
set -e
EXAMPLES="blank gitlab"

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
build_example(){
  PROVISION_CMD="/bin/sh /home/ce-dev/ce-provision/scripts/provision.sh"
  PROVISION_CMD="$PROVISION_CMD --repo dummy --branch dummy --workspace /home/ce-dev/ce-provision/ce-dev/ansible --playbook examples/$1/$1.yml"
  sudo docker exec -t --workdir /home/ce-dev/ce-provision --user ce-dev provision-controller "$PROVISION_CMD"
}

init_ce_dev

for EXAMPLE in $EXAMPLES; do
  build_example "$EXAMPLE"
done