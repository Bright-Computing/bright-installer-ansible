# Example playbook: Bright on Azure 

This playbook performs a network install of a Bright Cluster head node on Azure. As a simple example, it contains the following files.

- `playbook.yml`
- `requirements-control-node.txt`
- `tasks`
  - `resolve_azure_params.yml`
- `inventory`
    - `hosts`
- `group_vars/head_node`
    - `cluster-settings.yml`
    - `cluster-credentials.yml`

## Quickstart guide

This guide assumes that machines are prepared according to the requirements as specified in the [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92).

### 1. Install Ansible collection

```sh
$ ansible-galaxy collection install brightcomputing.installer92
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'brightcomputing.installer92:1.0.149+gitd15f4f6' to '/home/example/.ansible/collections/ansible_collections/brightcomputing/installer'
Downloading https://galaxy.ansible.com/download/brightcomputing-installer92-1.0.149+gitd15f4f6.tar.gz to /home/example/.ansible/tmp/ansible-local-220503_dk8flv/tmpsip0qgrl
brightcomputing.installer92 (1.0.149+gitd15f4f6) was installed successfully
```

Install the Python dependencies.

```sh
$ pip install -r requirements-control-node.txt
```

For management of Azure resources, also install the `azure.azcollection` collection.

```sh
$ ansible-galaxy collection install azure.azcollection
```

### 2. Configure parameters

In addition to the mandatory top-level parameters and the network install parameters as specified in [the non-cloud example playbook](../non-cloud/), the Azure deployment type has multiple unique parameters. See [Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) for a comprehensive overview. The Azure playbook example sets the following subset of parameters in addition to the mandatory parameters. (also see the YAML configuration files in [`group_vars/head_node`](group_vars/head_node/))

```yaml
# Azure settings
cloud: azure
```

```yaml
# Azure credentials
azure_cloud_provider_subscription_id: ! vault <encrypted string>
azure_cloud_provider_client_id: ! vault <encrypted string>
azure_cloud_provider_client_secret: ! vault <encrypted string>
azure_cloud_provider_tenant_id: ! vault <encrypted string>
```

The following settings are automatically configured by the tasks run from `tasks/resolve_azure_params.yml`. They *can* be configured manually, but then it is important to remove those respective tasks from the playbook.

```yaml
azure_cloud_provider_resource_group: cluster-rg
azure_cloud_provider_storage_account_name: cluster-sa
azure_network_name: vpc-cluster-subnet
azure_network_cloud_subnet_id: /subscriptions/e3c03c7a-acc7-480f-b88f-e63505793fc7/resourceGroups/cluster-rg/providers/Microsoft.Network/virtualNetworks/vpc-cluster/subnets/vpc-cluster-subnet
```

### 3. Run the playbook

Invoke the playbook and pass it an inventory file specifying a target `head_node` host.

```sh
$ ansible-playbook -i inventory/hosts playbook.yml
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) provides a comprehensive overview of all the options for installing Bright Cluster head nodes.
