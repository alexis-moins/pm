#!/usr/bin/env bash
#
# <pm> install script
#
destination="${1}"

if [[ -z "${destination}" ]]; then
    echo "missing required argument: DESTINATION"
    echo "usage: install.sh DESTINATION"
    exit 1
fi

if [[ -f "${destination}/pm" ]]; then
    echo "script already installed"
    exit 0
fi

[[ ! -d "${destination}" ]] && command mkdir -p "${destination}"

share="${HOME}/.local/share/pm"

[[ ! -d "${share}" ]] && command mkdir -p "${share}"

command cp -R ./backends "${share}/backends"
command cp -R ./templates "${share}/templates"

command cp ./pm "${destination}/pm"
