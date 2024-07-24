#!/usr/bin/env bash
#
# Uninstall script
#
destination="${1:-"${HOME}/.local/bin"}"

# Remove config
./pm uninstall-hook

command rm "${destination}/pm"
