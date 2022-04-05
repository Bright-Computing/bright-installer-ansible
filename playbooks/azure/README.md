# Example playbook: Bright on Azure 

This playbook performs a network install of a Bright Cluster head node on Azure. As a simple example, it contains the following files.

- `playbook.yml`
- `tasks`
  - `resolve_azure_params.yml`
- `inventory`
    - `hosts`
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

For management of Azure resources, also install the `azure.azcollection` collection.

```sh
$ ansible-galaxy collection install azure.azcollection
```

### 2. Configure parameters

In addition to the mandatory top-level parameters and the network install parameters as specified in [the non-cloud example playbook](../non-cloud/), the Azure deployment type has multiple unique parameters. See [Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer) for a comprehensive overview. The Azure playbook example sets the following subset of parameters in addition to the mandatory parameters. (also see the YAML configuration files in [`group_vars/head_node`](group_vars/head_node/))

```yaml
# Azure settings
cloud: azure
# The following Azure settings can be determined by the tasks specified in
# resolve_azure_params.yml, but they can also be set explicitly.
azure_cloud_provider_resource_group: cluster-rg
azure_cloud_provider_storage_account_name: cluster-sa
azure_network_name: vpc-cluster-subnet
azure_network_cloud_subnet_id: /subscriptions/e3c03c7a-acc7-480f-b88f-e63505793fc7/resourceGroups/cluster-rg/providers/Microsoft.Network/virtualNetworks/vpc-cluster/subnets/vpc-cluster-subnet
```

| variable name | type/format | variable description |
| ------------- | ----------- | -------------------- |
| azure_cloud_provider_resource_group | string | Azure resource group |
| azure_cloud_provider_storage_account_name | string | Azure storage account name |
| azure_network_name | string | Azure network name |
| azure_network_cloud_subnet_id | string | Azure network subnet id |
| azure_cloud_provider_default_node_installer_image | string | Azure default node installer image |

```yaml
# Azure credentials
azure_cloud_provider_subscription_id: ! vault <encrypted string>
azure_cloud_provider_client_id: ! vault <encrypted string>
azure_cloud_provider_client_secret: ! vault <encrypted string>
azure_cloud_provider_tenant_id: ! vault <encrypted string>
```

| variable name | type/format | variable description |
| ------------- | ----------- | -------------------- |
| azure_cloud_provider_subscription_id | string | Azure subscription id |
| azure_cloud_provider_client_id | string | Azure client id |
| azure_cloud_provider_client_secret | string | Azure client secret |
| azure_cloud_provider_tenant_id | string | Azure tenant ID |

### 3. Run the playbook

Invoke the playbook and pass it an inventory file specifying a target `head_node` host.

```sh
$ ansible-playbook -i inventory/hosts playbook.yml
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer) provides a comprehensive overview of all the options for installing Bright Cluster head nodes. 