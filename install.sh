#!/usr/bin/env bash
#
# Install script
#
destination="${1:-"${HOME}/.local/bin"}"

# Setup pm before installing
./pm install-hook

command cp -i pm "${destination}/pm"
