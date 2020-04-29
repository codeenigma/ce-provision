#!/bin/sh

set -eu

export ANSIBLE_FORCE_COLOR=True
export ANSIBLE_CONFIG="$OWN_DIR/ansible.cfg"

# Default variables.
TARGET_PROVISION_REPO=""
TARGET_PROVISION_PLAYBOOK=""
TARGET_PROVISION_BRANCH=""
ANSIBLE_EXTRA_VARS=""
ANSIBLE_DEFAULT_EXTRA_VARS=""
BUILD_WORKSPACE=""
BUILD_WORKSPACE_BASE="$OWN_DIR/build"
BUILD_ID=""
FORCE_PLAY="no"
if [ ! -d "$BUILD_WORKSPACE_BASE" ]; then
    mkdir "$BUILD_WORKSPACE_BASE"
fi
BUILD_TMP_DIR=$(mktemp -d -p "$BUILD_WORKSPACE_BASE")
ANSIBLE_DATA_DIR="$OWN_DIR/data"
if [ ! -d "$ANSIBLE_DATA_DIR" ]; then
    mkdir "$ANSIBLE_DATA_DIR"
fi
# Parse options arguments.
parse_options(){
  while [ "${1:-}" ]; do
    case "$1" in
      "--repo")
          shift
          TARGET_PROVISION_REPO="$1"
        ;;
      "--branch")
          shift
          TARGET_PROVISION_BRANCH="$1"
        ;;
      "--playbook")
          shift
          TARGET_PROVISION_PLAYBOOK="$1"
        ;;
      "--ansible-extra-vars")
          shift
          ANSIBLE_EXTRA_VARS="$1"
        ;;
      "--workspace")
          shift
          BUILD_WORKSPACE="$1"
        ;;
      "--force")
          FORCE_PLAY="yes"
        ;;
        *)
        usage
        exit 1
        ;;
    esac
    shift
  done
}

# An ID for the build.
get_build_id(){
  BUILD_ID="$(echo "$TARGET_PROVISION_REPO-$TARGET_PROVISION_BRANCH-$TARGET_PROVISION_PLAYBOOK" | tr / - | tr : -)"
}

# Compute defaults variables.
get_build_workspace(){
  BUILD_WORKSPACE=$(mktemp -d -p "$BUILD_WORKSPACE_BASE")
}

# Common extra-vars to pass to Ansible.
get_ansible_defaults_vars(){
  get_build_id
  ANSIBLE_DEFAULT_EXTRA_VARS="{_ansible_provision_base_dir: $OWN_DIR, _ansible_provision_build_dir: $BUILD_WORKSPACE, _ansible_provision_build_tmp_dir: $BUILD_TMP_DIR, _ansible_provision_data_dir: $ANSIBLE_DATA_DIR, _ansible_provision_build_id: $BUILD_ID, _ansible_provision_force_play: $FORCE_PLAY}"
}

# Clone our target repo.
repo_target_clone(){
  git clone "$TARGET_PROVISION_REPO" "$BUILD_WORKSPACE" --depth 1 --branch "$TARGET_PROVISION_BRANCH"
}

# Remove build directory.
cleanup_build_workspace(){
  if [ -n "$BUILD_WORKSPACE" ] && [ -d "$BUILD_WORKSPACE" ]; then
    rm -rf "$BUILD_WORKSPACE"
  fi
  cleanup_build_tmp_dir
}

# Remove tmp directory.
cleanup_build_tmp_dir(){
  if [ -n "$BUILD_TMP_DIR" ] && [ -d "$BUILD_TMP_DIR" ]; then
    rm -rf "$BUILD_TMP_DIR"
  fi
}
# Trigger actual Ansible job.
ansible_play(){
  /usr/bin/ansible-playbook --verbose "$BUILD_WORKSPACE/$TARGET_PROVISION_PLAYBOOK" --extra-vars "$ANSIBLE_DEFAULT_EXTRA_VARS" --extra-vars "$ANSIBLE_EXTRA_VARS"
  return $?
}