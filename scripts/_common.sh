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
DRY_RUN="no"
VERBOSE="no"
BOTO_PROFILE=""
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
      "--dry-run")
          DRY_RUN="yes"
        ;;
      "--verbose")
          VERBOSE="yes"
        ;;
      "--own-branch")
          shift
          git_checkout_own_dir "$1"
        ;;
      "--config-branch")
          shift
          git_checkout_config_dir "$1"
        ;;
      "--boto-profile")
          shift
          BOTO_PROFILE="$1"
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
  ANSIBLE_DEFAULT_EXTRA_VARS="{_ce_provision_base_dir: $OWN_DIR, _ce_provision_build_dir: $BUILD_WORKSPACE, _ce_provision_build_tmp_dir: $BUILD_TMP_DIR, _ce_provision_data_dir: $ANSIBLE_DATA_DIR, _ce_provision_build_id: $BUILD_ID, _ce_provision_force_play: $FORCE_PLAY}"
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
  ANSIBLE_CMD="/usr/bin/ansible-playbook $BUILD_WORKSPACE/$TARGET_PROVISION_PLAYBOOK"
  if [ "$DRY_RUN" = "yes" ]; then
    ANSIBLE_CMD="$ANSIBLE_CMD --check"
  fi
  if [ "$VERBOSE" = "yes" ]; then
    ANSIBLE_CMD="$ANSIBLE_CMD -vvvv"
  fi
  if [ -n "$BOTO_PROFILE" ]; then
    export AWS_PROFILE="$BOTO_PROFILE"
  fi
  $ANSIBLE_CMD --extra-vars "$ANSIBLE_DEFAULT_EXTRA_VARS" --extra-vars "$ANSIBLE_EXTRA_VARS"
  return $?
}

# Update repository.
# @param $1 absolute path to local repo.
# @param $2 branch to checkout.
git_checkout(){
  git -C "$1" checkout "$2"
  git -C "$1" pull origin "$2"
}

# Update own repository.
# @param $1 branch to checkout.
git_checkout_own_dir(){
  git_checkout "$OWN_DIR" "$1"
}

# Update own repository.
# @param $1 branch to checkout.
git_checkout_config_dir(){
  git_checkout "$OWN_DIR/config" "$1"
}
