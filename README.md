# Bright Cluster head node installer Ansible collection examples

This repository contains usage examples for the `brightcomputing.installer` Ansible collection.

To immediately jump to one of the example Playbooks, see

- [AWS](playbooks/aws/)
- [Azure](playbooks/azure/)
- [Non-cloud](/playbooks/non-cloud)

The remainder of this document provides a high-level overview of the installer Ansible collection.

## Introduction

An Ansible collection is the standard way for shipping and consuming Ansible distributables (playbooks, roles, plugins) since version 2.10. This document assumes that the user has practical knowledge of Ansible and Bright Cluster Manager.

This document briefly describes the procedure for deploying a Bright Cluster head node through an Ansible playbook using the head node installer Ansible collection. The collection defines the `brightcomputing.installer.head_node` role that deploys the Bright Cluster Manager head node when defined with the correct parameters in the user’s playbooks and roles. The head node installation also includes deployment of the default software image and node-installer image components, which is required for provisioning compute nodes.

## Terminology

Throughout this document, **control node** refers to the machine from where the Ansible playbook is being run and where the Ansible collection is installed. Managed node or **host** refers to the machine where the Bright head node is being deployed.

## Supported versions
Linux distributions:
* Rocky Linux 8.5
* Redhat Enterprise Linux 8.5
* Ubuntu 20.04 LTS
* Ubuntu 18.04 LTS

Bright versions:
* Bright Cluster Manager 9.2

## Using this collection

### Requirements

*See the [Ansible Galaxy README](https://galaxy.ansible.com/brightcomputing/installer) for a comprehensive overview of requirements.*

### Installation

Install the collection using the `ansible-galaxy` command-line tool:

```sh
ansible-galaxy collection install brightcomputing.installer
```

See [Ansible Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.

### Running the head node installer

The head node installer collection can be referenced by its name in a Playbook. Assign the `head_node` role to a host pattern in order to use the installer.

```yaml
- name: <play name>
  hosts: <pattern>
  roles:
    - role: brightcomputing.installer.head_node
      vars:
        <parameters>
```

### Parameters

*See the [Ansible Galaxy README](https://galaxy.ansible.com/brightcomputing/installer) for a comprehensive overview of parameters.*

There are mandatory parameters related to the product license.

| Parameter | Type/Format | Description |
| ------------- | ----------- | -------------------- |
| product_key | XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX | A Bright Computing product key used to request a license for the deployment |
| license.country | string | The country value to use for the certificate request |
| license.state | string  | The state or province name to use for the certificate request |
| license.locality | string | The locality name to use for the certificate request |
| license.organization | string | The organization name to use for the certificate request|
| license.organizational_unit | string | The organization unit name to use for the certificate request |
| license.cluster_name | string | The cluster name (common name) name to use for the certificate request |
| license.mac | mac | The mac address value to use for the certificate request |

There are also mandatory credential parameters. It is strongly recommended to manage these (and similar parameters) using [Ansible Vault](https://docs.ansible.com/ansible/latest/cli/ansible-vault.html).

| Parameter | Type/Format | Description |
| ------------- | ----------- | -------------------- |
| db_cmd_password | string | CMDaemon service database password |
| ldap_root_pass | string | LDAP root password to configure ldap service with|
| ldap_readonly_pass | string | LDAP read only password to configure ldap service with|
| slurm_user_pass | string | SLURM user password for database access |

Furthermore, there are connectivity-related parameters. `management_interface` needs to be set for all types of cloud deployment. Depending on the platform (AWS, Azure, non-cloud), there are additional mandatory parameters. See the specific examples for details.

| Parameter | Type/Format | Description |
| ------------- | ----------- | -------------------- |
| management_interface | string | The head node management network interface  |

And then there are install medium parameters. Depending on the choice of install medium (dvd, network, or local), there are different mandatory parameters to be specified.

| Parameter | Type/Format | Description |
| ------------- | ----------- | -------------------- |
| install_medium |  choice of [dvd, network, local] | Medium type that the installer will use for the installation of Bright |
| **dvd** | | |
| install_medium_dvd_path | path | Path to Bright-provided iso or path to device with the DVD on it |
| install_medium_dvd_checksum_path | path | Path to file containing md5 checksum of Bright iso (optional)|
| **network** | | |
| install_medium_network_packages | list[string] | List of paths to all packages provided by Bright that will define Bright Package repositories |
| **local** | | |
| install_medium_local_repo_path | path | Path to local file that defines the list of package repositories to fetch Bright package from |


## Examples

- Playbooks
- Var files

## Stages of the head node installer

## Licensing

Licensed under the Apache License, Version 2.0 (the "License")

See [LICENSE](http://www.apache.org/licenses/LICENSE-2.0) for the full text.