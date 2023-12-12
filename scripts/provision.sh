#!/bin/sh

set -eu

usage(){
  echo 'provision.sh [OPTIONS] --repo <git repo to provision> --branch <branch to provision> --playbook <path to playbook>'
  echo 'Provision a target.'
  echo ''
  echo 'Mandatory arguments:'
  echo '--repo: Path to a remote git repo. The "provision" user must have read access to it.'
  echo '--branch: The branch to provision.'
  echo '--playbook: Relative path to an ansible playbook within the repo. Can be a folder containing plays if the --parallel option is used.'
  echo ''
  echo 'Available options:'
  echo '--ansible-extra-vars: Variable to pass as --extra-vars arguments to ansible-playbook. Make sure to escape them properly.'
  echo '--ansible-path: Pass the path to the directory containing the Ansible binaries if you are not using the version of Ansible in PATH.'
  echo '--workspace: Local existing clone of the repo/branch (if your deployment tool already has one). This will skip the cloning/fetching of the repo.'
  echo '--user: Linux user executing the script (defaults to controller).'
  echo '--absolute-playbook-path: Prevent prepending of the workspace path to the playbook path when Ansible is called.'
  echo '--force: Bypass the md5 checks on playbooks and play them regardless.'
  echo '--dry-run: Do not perform any action but run the playbooks in --check mode.'
  echo '--list-tasks: Do not perform any action but run the playbooks with --list-tasks.'
  echo '--verbose: Detailed informations. This can potentially leak sensitive information in the output.'
  echo '--own-branch: Branch to use for the main stack repository.'
  echo '--config-branch: Branch to use for the main stack config repository.'
  echo '--boto-profile: Name of a profile to export as AWS_PROFILE before calling Ansible.'
  echo '--parallel: Run all playbooks in the --playbook directory in parallel (using ansible-parallel).'
  echo '--lint: Run ansible-lint against the playbooks instead of executing them.'
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
if [ -z "$TARGET_PROVISION_REPO" ] || [ -z "$TARGET_PROVISION_PLAYBOOK" ] || [ -z "$TARGET_PROVISION_BRANCH" ]; then
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

# Get Ansible defaults.
get_ansible_defaults_vars

# Trigger deploy.
ansible_play
