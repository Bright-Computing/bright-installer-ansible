# Intro
This example deploys Bright Cluster Manager 9.2 on a vagrant RockyLinux 8.5 vm.
We assume the user has access to either `cm-config-cm.noarch.rpm` and `cm-config-yum.noarch.rpm` packages for an network install or `bright9.2-rocky8u5.iso` and `bright9.2-rocky8u5.iso.md5` for iso based install.

# Requirements:
- qemu (with kvm):  https://www.qemu.org/
- libvirtd:         https://libvirt.org/
- vagrant:          https://www.vagrantup.com/


# Runing the example
Create a vagrant machine with RockyLinux 8.5 and install and enable `mariadb` (using prepare.yml playbook)
```
$ ./provision.sh --create
```

Export `PRODUCT_KEY` variable for a license request.
```
$ export PRODUCT_KEY=XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX
```

For network install, rerun `./provision.sh` with `--install-network` flag and `BRIGHT_PKG_MIRROR` variable set to the url to dowload `cm-config-cm.noarch.rpm` and `cm-config-yum.noarch.rpm` packages from.
```
$ BRIGHT_PKG_MIRROR=<URL-TO-DOWLOAD-PKGS-FROM> ./provision --install-network
```

For iso install, rerun `./provision.sh` with `--install-iso` and `BRIGHT_ISO_MIRROR` variable set to the url to dowload `bright9.2-rocky8u5.iso` and `bright9.2-rocky8u5.iso.md5` from.
```
$ BRIGHT_ISO_MIRROR=<URL-TO-DOWLOAD-ISO-FROM> ./provision --install-iso
```

Destroy all created vms once done with them.
```
./provision --destroy
```
