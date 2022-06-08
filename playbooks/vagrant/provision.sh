#!/bin/bash -e

ANSIBLE_ARGS="${ANSIBLE_ARGS:'--vv'}"
export VAGRANT_DEFAULT_PROVIDER=libvirt

create_vm() {
    vagrant up
}

remove_vm() {
    vagrant destroy -f
}

_run_install_playbook() {
    : "${PRODUCT_KEY?You have to call this script with variable PRODUCT_KEY set for the cluster license.}"
    local medium=${1}
    ansible-playbook -vv install-${medium}.yml
    vagrant reload
    sleep 10 # wait a bit for cmdaemon to come up.
    ansible-playbook -vv define-compute-nodes.yml
    vagrant up node001
    vagrant up node002
}

install_iso() {
    : "${BRIGHT_ISO_MIRROR?You have to call this script with variable BRIGHT_ISO_MIRROR set for iso install.}"
    make init download-iso
    _run_install_playbook iso
}

install_network() {
    : "${BRIGHT_PKG_MIRROR?You have to call this script with variable BRIGHT_PKG_MIRROR set for network install.}"
    make init download-repo-packages
    _run_install_playbook network
}

action="create"
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --create) action="create_vm" ;;
        --remove) action="remove_vm" ;;
        --destroy) action="remove_vm" ;;
        --install-iso) action="install_iso" ;;
        --install-network) action="install_network" ;;
        *) echo "Unknown action passed: $1"; exit 1 ;;
    esac
    shift
done

${action}
