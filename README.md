# Bright head node installer Ansible collection

## Introduction
Ansible collection is the standard way for shipping and consuming ansible distributables (playbooks, roles, plugins) since version 2.10. This document assumes that the user has practical knowledge of Ansible and Bright Cluster Manager.

This document describes the procedure to deploy a Bright Cluster head node using an Ansible playbook that makes uses of the head node installer collection. The head node installer is shipped as an Ansible collection. The collection defines brightcomputing.installer.head_nodethat deploys the Bright Cluster Manager Head Node when defined with the correct parameters in the user’s playbooks and roles. The head node installation also includes deploying the default software image and node-installer image components to be able to provision compute nodes.

## Terminology
Throughout this document the host refers to the machine from where the Ansible playbook is being run and the Ansible collection is installed, and the target refers to the machine where the Bright head node is being deployed.

## Supported Linux distributions and Bright versions
Linux distributions:
* Rocky Linux 8.5
* Redhat Enterprise Linux 8.5
* Ubuntu 20.04 LTS
* Ubuntu 18.04 LTS

Bright versions:
* Bright Cluster Manager 9.2

## Requirements on the host
* Ansible version 2.10 or higher
* Python 3
* Python 3 Pip modules
  ** jmespath (required for community.general.json_query filter)
  ** xmltodict (required for brightcomputing.insaller.xml filter)
  ** netaddr (required for ansible.netcommon.ipaddr filter)

## Requirements on the target
* A fresh install of one of the supported Linux distributions mentioned on the “Supported Linux Distributions” section of this file.
* Python 3
* mysql-server (or mariadb) installed and the root password set
* selinux disabled
