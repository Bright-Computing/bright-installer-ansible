# Bright Cluster head node installer Ansible collection

This repository contains the `brightcomputing.installer` Ansible collection. It includes the `brightcomputing.installer.head_node` role for deploying Bright Cluster Manager head nodes.

## Introduction

An Ansible collection is the standard way for shipping and consuming Ansible distributables (playbooks, roles, plugins) since version 2.10. This document assumes that the user has practical knowledge of Ansible and Bright Cluster Manager.

This document describes the procedure for deploying a Bright Cluster head node through an Ansible playbook using the head node installer Ansible collection. The collection defines the `brightcomputing.installer.head_node` role that deploys the Bright Cluster Manager head node when defined with the correct parameters in the user’s playbooks and roles. The head node installation also includes deployment of the default software image and node-installer image components, which is required for provisioning compute nodes.

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

On the control node:
* Ansible version 2.10 or higher
* Python 3
* Python 3 pip modules
  * `jmespath` (required for `community.general.json_query` filter)
  * `xmltodict` (required for `brightcomputing.installer.xml` filter)
  * `netaddr` (required for `ansible.netcommon.ipaddr` filter)

On the hosts:
* A fresh install of one of the [supported Linux distributions](#supported-versions)
* Python 3
* MySQL-server (or MariaDB) installed, with the root password set
* SELinux disabled

### Installation

### Running the head node installer

## Parameters

## Examples

- Playbooks
- Var files

## Stages of the head node installer

## Licensing

Licensed under the Apache License, Version 2.0 (the "License")

See [LICENSE](http://www.apache.org/licenses/LICENSE-2.0) for the full text.