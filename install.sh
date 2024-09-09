#!/usr/bin/env bash
#
# Install script
#
WHITE="\e[0m"
GREEN="\e[32;1m"

destination="${1:-"${HOME}/.local/bin"}"

# Install templates and backends
./pm install-hook

if [[ ! -f "${destination}/pm" ]]; then
    command cp -i pm "${destination}/pm"
fi

echo -e "${GREEN}✓${WHITE} pm is ready to use"
