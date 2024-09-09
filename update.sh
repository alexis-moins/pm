#!/usr/bin/env bash
#
# Update script
#
set -e

destination="${1:-"${HOME}/.local/bin"}"

./uninstall.sh "${destination}" 1> /dev/null

command git pull

./install.sh "${destination}"
