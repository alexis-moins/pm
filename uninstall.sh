#!/usr/bin/env bash
#
# <pm> uninstall script
#
destination="${1}"

if [[ -z "${destination}" ]]; then
    echo "missing required argument: DESTINATION"
    echo "usage: uninstall.sh DESTINATION"
    exit 1
fi

if [[ ! -f "${destination}/pm" ]]; then
    echo "=> pm not found"
    exit 1
fi

share="${HOME}/.local/share/pm"

[[ -d "${share}/backends" ]] && command rm -rf "${share}/backends"
[[ -d "${share}/templates" ]] && command rm -rf "${share}/templates"

command rm "${destination}/pm"
