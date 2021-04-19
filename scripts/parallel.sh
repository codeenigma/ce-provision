#!/bin/sh

set -eu

usage(){
  echo 'parallel.sh [OPTIONS] --repo <git repo to provision> --branch <branch to provision> --playbooks-dir <path to playbook dir>'
  echo 'Provision multiple targets in parallel.'
  echo ''
  echo 'Mandatory arguments:'
  echo '--repo: Path to a remote git repo. The "provision" user must have read access to it.'
  echo '--branch: The branch to provision.'
  echo '--playbooks-dir: Relative path to an ansible folder containing playbooks within the repo.'
  echo ''
  echo 'Available options:'
  echo '--ansible-extra-vars: Variable to pass as --extra-vars arguments to ansible-playbook. Make sure to escape them properly.'
  echo '--workspace: a local existing clone of the repo/branch (if your deployment tool already has one). This will skip the cloning/fetching of the repo.'
  echo '--force: bypass the md5 checks on playbooks and play them regardless.'
  echo '--dry-run: Do not perform any action but run the playbooks in --check mode.'
  echo '--verbose: Detailled informations. This can potentially leak sensitive information in the output'
  echo '--own-branch: Branch to use for the main stack repository'
  echo '--config-branch: Branch to use for the main stack config repository'
  echo '--boto-profile: Name of a profile to export as AWS_PROFILE before calling Ansible'
}

# Common processing.
OWN_DIR=$(dirname "$0")
cd "$OWN_DIR" || exit 1
OWN_DIR=$(git rev-parse --show-toplevel)
cd "$OWN_DIR" || exit 1
OWN_DIR=$(pwd -P)

# shellcheck source=./_common.sh
. "$OWN_DIR/scripts/_common.sh"

# Parse options.
parse_options "$@"

# Check we have enough arguments.
if [ -z "$TARGET_PROVISION_REPO" ] || [ -z "$TARGET_PROVISION_PLAYBOOKS_DIR" ] || [ -z "$TARGET_PROVISION_BRANCH" ]; then
 usage
 exit 1
fi

trap cleanup_build_tmp_dir EXIT INT TERM QUIT HUP

# If we have no workspace, create it and clone the repo.
if [ -z "$BUILD_WORKSPACE" ]; then
  trap cleanup_build_workspace EXIT INT TERM QUIT HUP
  get_build_workspace
  repo_target_clone
fi

# Trigger} builds of all playbooks.
for PLAYBOOK in "$BUILD_WORKSPACE/$TARGET_PROVISION_PLAYBOOKS_DIR/"*.yml; do
    /bin/sh "$OWN_DIR/scripts/provision.sh" --playbook "$TARGET_PROVISION_PLAYBOOKS_DIR/$(basename "$PLAYBOOK")" "$@" &
done 