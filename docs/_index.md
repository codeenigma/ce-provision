# ce-provision

A set of Ansible roles and wrapper scripts to configure remote (Debian) machines.

## Overview

The "stack" from this repo is to be installed on a "controller" server/runner, to be used in conjonction with a CI/CD tool (Jenkins, Gitlab, Travis, ...).
It allows the configuration for a given service to be easily customizable at will, and to be stored in a git repository.
When triggered from a deployment tool, the stack will clone the codebase and "play" a given deploy playbook from there.
