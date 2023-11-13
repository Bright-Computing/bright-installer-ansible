# Example playbook: Bright on Azure

This playbook performs a network install of a Bright Cluster head node on Azure. As a simple example, it contains the following files.

- `group_vars/head_node`
    - `cluster-settings.yml`
    - `cluster-credentials.yml`
- `inventory`
    - `hosts`
- `requirements`
  - `controller-machine.txt`
  - `target-machine.txt`
  - `ansible.txt`
- `tasks`
  - `resolve_azure_params.yml`
- `vars`
    - `credentials.yml`
    - `stack.yml`
- `create_stack.yml`
- `install.yml`
- `prepare.yml`
- `remove_stack.yml`

## Quickstart guide

This guide assumes that machines are prepared according to the requirements as specified in the [collection on Ansible Galaxy](https://galaxy.ansible.com/ui/repo/published/brightcomputing/installer92).

### 1. Install Ansible collection

Create and activate a virtual environment.

```sh
$ python -m venv venv
$ source venv/bin/activate
```

Install the Python dependencies.

```sh
$ pip install -r requirements/controller-machine.txt
$ ansible-galaxy collection install -r requirements/ansible.yml
```

Install Ansible brightcomputing.installer collection.

```sh
$ ansible-galaxy collection install brightcomputing.installer92
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Downloading https://galaxy.ansible.com/api/v3/plugin/ansible/content/published/collections/artifacts/brightcomputing-installer92-14.0.276+gitf0d2650.tar.gz to /home/med/.ansible/tmp/ansible-local-368039xkpcf86/tmprzvnyk32/brightcomputing-installer92-14.0.276+gitf0d2650-_nub6k31
Installing 'brightcomputing.installer92:14.0.276+gitf0d2650' to '/home/med/.ansible/collections/ansible_collections/brightcomputing/installer92'
brightcomputing.installer92:14.0.276+gitf0d2650 was installed successfully
```

### 2. Configure parameters

#### 2.1 Configure credentials
Before proceeding with the playbooks to create Azure resources and later run the deployment playbooks, it's crucial to set up the appropriate credentials for Ansible. These credentials are necessary for making calls to the Azure API and interacting with Azure services during the deployment.

Here's a guide on configuring Azure credentials:

1. **Azure Credentials Configuration**: Azure credentials can be configured in multiple ways. You can refer to the official Ansible documentation [here](https://docs.ansible.com/ansible/latest/scenario_guides/guide_azure.html#authenticating-with-azure) for detailed instructions. Choose one of the authentication methods that best suits your requirements. These credentials will allow you to create and remove the Azure stack using the `create_stack.yml` and `remove_stack.yml` playbooks.

2. **Deployment Playbook Authentication Parameters**: To enable the deployment playbooks (responsible for installing and configuring the BCM cluster manager on your Azure stack), you'll need to make certain authentication parameters available to them. These credentials should be exported to the deployment playbook as variables.
The variables that need to be configured are listed in the [credentials variable file](./vars/credentials.yml). You can find detailed documentation for these variables in the Azure subsection of the `brightcomputing.installer92` README on the public [Ansible Galaxy](https://galaxy.ansible.com/ui/repo/published/brightcomputing/installer92/docs/).

Ensuring the correct setup of authentication/credentials is a required step to ensure the successful execution of the playbooks for your Azure-based BCM cluster.

#### 2.2 Configure resource creation parameters
The example includes two playbooks that are helpful for creating the set of resources: `create_stack.yml` and `remove_stack.yml`. These playbooks can be configured through the `vars/stack.yml` file. You can adjust the variable values in that file to suit your requirements. There is nothing particularly unique about the existing configuration.

#### 2.3 Configure installer parameters
In addition to the mandatory top-level parameters and the network install parameters as specified in [the non-cloud example playbook](../non-cloud/), the Azure deployment type has multiple unique parameters. See [Ansible Galaxy](https://galaxy.ansible.com/ui/repo/published/brightcomputing/installer92/docs/) for a comprehensive overview. The Azure playbook example sets the following subset of parameters in addition to the mandatory parameters. (also see the YAML configuration files in [group_vars/head_node](group_vars/head_node/))

`group_vars/head_node/cluster-settings.yml`:
```yaml
# Azure settings
[ ... ]
external_interface: eth1
external_ip_address: DHCP
[...]
```

`group_vars/head_node/cluster-credentials.yml`:
```yaml
# Cluster credentials
product_key: ! vault <encrypted string>
db_cmd_password: ! vault <encrypted string>
[ ... ]
```

The following settings are automatically configured by the tasks run from `tasks/resolve_azure_params.yml`. They *can* be configured manually, but then it is important to remove those respective tasks from the playbook.

```yaml
azure_cloud_provider_resource_group: cluster-rg
azure_cloud_provider_storage_account_name: cluster-sa
azure_network_name: vpc-cluster-subnet
azure_network_cloud_subnet_id: /subscriptions/e3c03c7a-acc7-480f-b88f-e63505793fc7/resourceGroups/cluster-rg/providers/Microsoft.Network/virtualNetworks/vpc-cluster/subnets/vpc-cluster-subnet
```

### 3. Run the playbooks

You can optionally invoke the playbook that creates the Azure stack using the `create_stack.yml` playbooks:

```sh
$ ansible-playbook create_stack.yml -v
```
This will create all the needed resources for a basic non HA BCM deployments.

Next, you can make use of the `prepare.yml` playbook to provision the software requirements for the Virtual machine using this command:

```sh
$ ansible-playbook -i inventory/hosts prepare.yml
```

Invoke the playbook and pass it an inventory file specifying a target `head_node` host. You need to update the [inventory file](./inventory/hosts) with the public IP address that is assigned during the execution of the `create_stack.yml` playbook (In case you created your Azure VM using `create_stack.yml` playbook). Set this IP address as the value of `ansible_host`, replacing the placeholder value of `host.example.com`.

```sh
$ ansible-playbook -i inventory/hosts install.yml
```

### 4. Clean up
In case you used the `create_stack.yml` playbook to create the Azure stack, you can make use of the corresponding `remove_stack.yml` playbook to clean it up once finished. This removal playbook will *only* remove the resources created by the `create_stack.yml`. It's important to mention this because you might have created some cloud nodes, and the `remove_stack.yml` won't be able to remove those. It will actually error out when trying to remove the resource group.

```sh
$ ansible-playbook remove_stack.yml -v
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/ui/repo/published/brightcomputing/installer92/docs) provides a comprehensive overview of all the options for installing Bright Cluster head nodes.
