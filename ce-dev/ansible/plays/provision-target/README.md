# provision-target

This is the location for the playbook for the `provision-target` container, a blank target server which has standard privileges and should be used for most usecases.

YAML files in this directory are deliberately ignored because your `provision-target.yml` file will always be different depending on what you're testing. To get you started, here is an example playbook which you can copy and save as `ce-dev/ansible/plays/provision-target/provision-target.yml`:


```yaml
- hosts: provision-target
  become: true

  vars:
    project_name: provision-target
    _ce_provision_base_dir: /home/ce-dev/ce-provision
    _ce_provision_force_play: true
    _init:
      vars_dirs:
        - "{{ _ce_provision_base_dir }}/ce-dev/ansible/vars/_common"
        - "{{ _ce_provision_base_dir }}/ce-dev/ansible/vars/{{ project_name }}"

  tasks:
    - ansible.builtin.import_role:
        name: _init
    - ansible.builtin.import_role:
        name: _meta/common_base
    - ansible.builtin.import_role:
        name: mysql_client
    - ansible.builtin.import_role:
        name: php-cli
    - ansible.builtin.import_role:
        name: php-fpm
    - ansible.builtin.import_role:
        name: nginx
    - ansible.builtin.import_role:
        name: _exit
```

Variables should be placed in the `ce-dev/ansible/vars/provision-target` directory, one YAML file per role. On a clean install this will not yet exist, as it is ignored by Git to avoid errors. You can look at the other vars directories in the same location for examples of how set it up. These vars files will get compiled and included by the `_init` role.

You can execute this playbook either directly with Docker like so:

```
sudo docker exec -t --workdir /home/ce-dev/ce-provision --user ce-dev provision-controller \
/bin/sh /home/ce-dev/ce-provision/scripts/provision.sh --repo dummy --branch dummy \
--workspace /home/ce-dev/ce-provision/ce-dev/ansible \
--playbook plays/provision-target/provision-target.yml
```

Or by using the `test.sh` script - though there are two things you should know first:

1. This will tear down your entire `ce-dev` environment and re-create it
2. You will need to make sure the `origin` remote of the `ce-provision` repo is set to use a Git URL and not a HTTPS one

```
ce-dev/ansible/test.sh --examples provision-target
```

