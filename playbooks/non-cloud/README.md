# Example playbook: Bright on non-cloud

This playbook performs a network install of a Bright Cluster head node on a non-cloud machine. As a simple example, it contains the following files.

- `playbook.yml`
- `requirements-control-node.txt`
- `inventory`
    - `hosts`
- `group_vars/head_node`
    - `cluster-settings.yml`
    - `cluster-credentials.yml`

## Quickstart guide

This guide assumes that machines are prepared according to the requirements as specified in the [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92).

### 1. Install Ansible collection

Create and activate a virtual environment.

```sh
$ python -m venv venv
$ source venv/bin/activate
```

Install the Python dependencies.

```sh
$ pip install -r requirements-control-node.txt
```

Install Ansible collection.

```sh
$ ansible-galaxy collection install brightcomputing.installer92
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'brightcomputing.installer92:1.0.149+gitd15f4f6' to '/home/example/.ansible/collections/ansible_collections/brightcomputing/installer'
Downloading https://galaxy.ansible.com/download/brightcomputing-installer92-1.0.149+gitd15f4f6.tar.gz to /home/example/.ansible/tmp/ansible-local-220503_dk8flv/tmpsip0qgrl
brightcomputing.installer92 (1.0.149+gitd15f4f6) was installed successfully
```

### 2. Configure parameters

In addition to the mandatory, top-level parameters, the non-cloud deployment type has multiple unique parameters. See [Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) for a comprehensive overview. The non-cloud playbook example sets the following subset of parameters in addition to the mandatory parameters. (also see the YAML configuration files in [`group_vars/head_node`](group_vars/head_node/))

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

```yaml
# Cluster credentials
mysql_login_user: ! vault <encrypted string>
mysql_login_password: ! vault <encrypted string>
```

### 3. Run the playbook

Invoke the playbook and pass it an inventory file specifying a target `head_node` host.

```sh
$ ansible-playbook -i inventory/hosts playbook.yml
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) provides a comprehensive overview of all the options for installing Bright Cluster head nodes.
