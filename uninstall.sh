#!/usr/bin/env bash
#
# Uninstall script
#
set -e

WHITE="\e[0m"
GREEN="\e[32;1m"

destination="${1:-"${HOME}/.local/bin"}"

# Path were pm stores its templates and backends
PM_DATA_DIR="${HOME}/.local/share/pm"

# Remove templates and backends
[[ -d "${PM_DATA_DIR}" ]] && command rm -rf "${PM_DATA_DIR}"

if [[ -f "${destination}/pm" ]]; then
    # Remove the pm script if it is a file or a symlink
    command rm "${destination}/pm"
fi

echo -e "${GREEN}✓${WHITE} pm has been removed"
