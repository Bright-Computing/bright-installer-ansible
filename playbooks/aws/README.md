# Example playbook: Bright on AWS

This playbook performs a network install of a Bright Cluster head node on AWS. As a simple example, it contains the following files.

- `playbook.yml`
- `requirements-control-node.txt`
- `tasks`
  - `resolve_aws_params.yml`
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

For management of AWS resources, also install the `amazon.aws` collection.

```sh
$ ansible-galaxy collection install amazon.aws
```

### 2. Configure parameters

In addition to the mandatory top-level parameters and the network install parameters as specified in [the non-cloud example playbook](../non-cloud/), the AWS deployment type has multiple unique parameters. See [Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) for a comprehensive overview. The AWS playbook example sets the following subset of parameters in addition to the mandatory parameters. (also see the YAML configuration files in [`group_vars/head_node`](group_vars/head_node/))

```yaml
# AWS settings
cloud: aws
aws_cloud_provider_default_director_type: t2.medium
aws_cloud_provider_default_region: eu-west-1
aws_cloud_provider_default_type: t3.medium
aws_cloud_provider_image_owners: 137677339600
aws_cloud_provider_ec2vpc_name: vpc-0
aws_cloud_provider_ec2vpc_region: eu-west-1
```

```yaml
# AWS credentials
aws_cloud_provider_username: ! vault <encrypted string>
aws_cloud_provider_account_id: ! vault <encrypted string>
aws_cloud_provider_access_key_id: ! vault <encrypted string>
aws_cloud_provider_access_key_secret: ! vault <encrypted string>
```

The following settings are automatically configured by the tasks run from `tasks/resolve_aws_params.yml`. They *can* be configured manually, but then it is important to remove those respective tasks from the playbook.

```yaml
aws_cloud_provider_ec2vpc_vpc_id: vpc-h1y7afhfpzhq9952j
aws_public_network_cloud_subnet_id: subnet-4cdgev5ds5iekbc5s
aws_private_network_cloud_subnet_id: subnet-fatgqn00tr82n56pd
aws_cloud_provider_ec2vpc_security_group_node: sg-nrjizsei1dfejcqla
aws_cloud_provider_ec2vpc_security_group_director: sg-7argmoa9c5pfmq76u
```

### 3. Run the playbook

Invoke the playbook and pass it an inventory file specifying a target `head_node` host.

```sh
$ ansible-playbook -i inventory/hosts playbook.yml
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) provides a comprehensive overview of all the options for installing Bright Cluster head nodes.
