#!/usr/bin/env bash
#
# Various helpers
#

alias vl='virsh list --all'

if [ "$(pidof spice-vdagent)" == "" ]; then
    spice-vdagent
fi

spiceme() {
    spice_uri=$(virsh domdisplay $1);
    if [ $? -ne 0 ]; then
        virsh list --inactive
    else
        spicy -f --uri=${spice_uri};
    fi
}

vmclone() {
    source="${1}"
    dest="${2}"
    diskimage="/var/lib/libvirt/images/${dest}.img"

    if [ -f "${diskimage}" ]; then
        echo "${diskimage} already exist."
        exit 1
    fi

    virt-clone -o ${source} -n ${dest} -f /var/lib/libvirt/images/${dest}.img
}

urlencode() {
    echo -n $1 | xxd -plain | sed 's/\(..\)/%\1/g'
}
