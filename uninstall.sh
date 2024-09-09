#!/usr/bin/env bash
#
# Uninstall script
#
set -e

WHITE="\e[0m"
GREEN="\e[32;1m"

destination="${1:-"${HOME}/.local/bin"}"

# Remove templates and backends
./pm uninstall-hook

if [[ -f "${destination}/pm" ]]; then
    command rm "${destination}/pm"
fi

echo -e "${GREEN}✓${WHITE} pm has been removed"
