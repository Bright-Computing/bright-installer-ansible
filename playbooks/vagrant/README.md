# Example deployment and playbook: Bright on Vagrant

This example deploys Bright Cluster Manager 9.2 on Vagrant RockyLinux 8.5 virtual machines.
We assume the user has access to either `cm-config-cm.noarch.rpm` and `cm-config-yum.noarch.rpm` packages for a network install or `bright9.2-rocky8u5.iso` and `bright9.2-rocky8u5.iso.md5` for an iso install.

This guide differs from the example playbooks for AWS, Azure, and non-cloud. Namely, it also includes automated provisioning of the Vagrant hosts and the required software dependencies.

## Quickstart guide

### 1. Install requirements

- [qemu (with kvm)](https://www.qemu.org)
- [libvirtd](https://libvirt.org)
- [Vagrant](https://www.vagrantup.com)
- [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)

### 2. Provision Vagrant machines

Create a vagrant machine with RockyLinux 8.5 and install and enable `mariadb` (using prepare.yml playbook)
```
$ ./provision.sh --create
```

Export `PRODUCT_KEY` variable for a license request.
```
$ export PRODUCT_KEY=XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX
```

### 3. Install Bright Cluster Manager

Either perform a network install or an iso install.

#### Network install
```
$ BRIGHT_PKG_MIRROR=<URL-TO-DOWLOAD-PKGS-FROM> ./provision --install-network
```
The `BRIGHT_PKG_MIRROR` variable must be set to the url from where to dowload `cm-config-cm.noarch.rpm` and `cm-config-yum.noarch.rpm`.

#### ISO install
```
$ BRIGHT_ISO_MIRROR=<URL-TO-DOWLOAD-ISO-FROM> ./provision --install-iso
```
The `BRIGHT_ISO_MIRROR` variable must be set to the url from where to download `bright9.2-rocky8u5.iso` and `bright9.2-rocky8u5.iso.md5`.

#### Clean up
```
./provision --destroy
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) provides a comprehensive overview of all the options for installing Bright Cluster head nodes.
