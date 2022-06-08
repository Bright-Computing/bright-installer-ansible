# Example deployment and playbook: Bright on Vagrant

This example deploys Bright Cluster Manager 9.2 on Vagrant RockyLinux 8.5 virtual machines.
We assume the user has access to either `cm-config-cm.noarch.rpm` and `cm-config-yum.noarch.rpm` packages for a network install or `bright9.2-rocky8u5.iso` and `bright9.2-rocky8u5.iso.md5` for an iso install.

This guide differs from the example playbooks for AWS, Azure, and non-cloud. Namely, it also includes automated provisioning of the Vagrant hosts and the required software dependencies.

## Quickstart guide

### Requirements

- [qemu (with kvm)](https://www.qemu.org)
- [libvirtd](https://libvirt.org)
- [Vagrant](https://www.vagrantup.com)

### Provision Vagrant machines

Create a vagrant machine with RockyLinux 8.5 and install and enable `mariadb` (using prepare.yml playbook)
```
$ ./provision.sh --create
```

Export `PRODUCT_KEY` variable for a license request.
```
$ export PRODUCT_KEY=XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX
```

### Install Bright Cluster Manager

For a network install, rerun `./provision.sh` with `--install-network` flag and `BRIGHT_PKG_MIRROR` variable set to the url to dowload `cm-config-cm.noarch.rpm` and `cm-config-yum.noarch.rpm` packages from.
```
$ BRIGHT_PKG_MIRROR=<URL-TO-DOWLOAD-PKGS-FROM> ./provision --install-network
```

For an iso install, rerun `./provision.sh` with `--install-iso` and `BRIGHT_ISO_MIRROR` variable set to the url to dowload `bright9.2-rocky8u5.iso` and `bright9.2-rocky8u5.iso.md5` from.
```
$ BRIGHT_ISO_MIRROR=<URL-TO-DOWLOAD-ISO-FROM> ./provision --install-iso
```

Destroy all created vms once done with them.
```
./provision --destroy
```

## Go further

The [collection on Ansible Galaxy](https://galaxy.ansible.com/brightcomputing/installer92) provides a comprehensive overview of all the options for installing Bright Cluster head nodes.
