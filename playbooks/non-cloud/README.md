# Example playbook: Bright on Rocky 8.5 for non-cloud

This playbook performs a network install of a Bright Cluster head node on a non-cloud Rocky 8.5 machine. As a simple example, it contains the following files.

- `playbook.yml`
- `inventory`
    - `hosts.yml`
- `group_vars/head_node`
    - `cluster-settings.yml`
    - `cluster-credentials.yml`

## Quickstart guide

This guide assumes that machines are prepared according to the requirements as specified in the [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer).

### 1. Install Ansible collection

```sh
$ ansible-galaxy collection install brightcomputing.installer
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'brightcomputing.installer:9.1.11+91.git735ce0e' to '/home/example/.ansible/collections/ansible_collections/brightcomputing/installer'
Downloading https://galaxy.ansible.com/download/brightcomputing-installer-9.1.11+91.git735ce0e.tar.gz to /home/example/.ansible/tmp/ansible-local-220503_dk8flv/tmpsip0qgrl
brightcomputing.installer (9.1.11+91.git735ce0e) was installed successfully
```

### 2. Configure parameters

In addition to the mandatory, top-level parameters, the non-cloud deployment type has multiple unique parameters. See [Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer) for a comprehensive overview. The non-cloud playbook example sets the following subset of parameters in addition to the mandatory parameters. (also see the YAML configuration files in [`group_vars/head_node`](group_vars/head_node/))

```yaml
# General cluster settings
external_interface: eth0
external_ip_address: DHCP
external_network_gateway: "{{ ansible_facts[external_interface].ipv4.address }}"
management_interface: eth1
management_ip_address: 10.142.255.254
management_network_baseaddress: 10.142.0.0
external_name_servers: [10.2.200.200]
install_medium: network
install_medium_network_packages:
  - "http://example.com/cm-config-cm.all.rpm"
  - "http://example.com/cm-config-yum.all.rpm"
```

| Parameter | Type/Format | Description |
| ------------- | ----------- | -------------------- |
| external_interface | string | The head node interface name as part on the external host  |
| external_ip_address | string | The head node interface address as part on the external host |
| external_network_gateway | string | The head node gateway address |
| management_ip_address | string | The head node network address on the management network |
| management_network_baseaddress | string | The network address for the head node's management network |

```yaml
# Cluster credentials
mysql_login_user: ! vault <encrypted string>
mysql_login_password: ! vault <encrypted string>
```

| Parameter | Type/Format | Description |
| ------------- | ----------- | -------------------- |
| mysql_login_user | string | The name of the MySQL database use that should be created |
| mysql_login_password | string | The desired password for the MySQL user |

### 3. Run the playbook

Invoke the playbook and pass it an inventory file specifying a target `head_node` host.

```sh
$ ansible-playbook -i inventory/hosts playbook.yml
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer) provides a comprehensive overview of all the options for installing Bright Cluster head nodes. 