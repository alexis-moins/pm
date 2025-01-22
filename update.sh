#!/usr/bin/env bash
#
# Update script
#
set -e

WHITE="\e[0m"
GREEN="\e[32;1m"

destination="${1:-"${HOME}/.local/bin"}"

./uninstall.sh "${destination}" &> /dev/null

command git pull

./install.sh "${destination}" &> /dev/null
