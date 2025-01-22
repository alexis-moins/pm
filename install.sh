#!/usr/bin/env bash
#
# Install script
#
set -e

WHITE="\e[0m"
GREEN="\e[32;1m"

destination="${1:-"${HOME}/.local/bin"}"

# Path were pm stores its templates and backends
PM_DATA_DIR="${HOME}/.local/share/pm"

[[ ! -d "${PM_DATA_DIR}" ]] && command mkdir -p "${PM_DATA_DIR}"

# Copy default templates and backends
command cp -R backends "${PM_DATA_DIR}/"
command cp -R templates "${PM_DATA_DIR}/"

# Sets the default global template
echo "default" > "${PM_DATA_DIR}/global-template"

# Sets the default global backend
echo "vscode" > "${PM_DATA_DIR}/global-backend"

[[ ! -f "${destination}/pm" ]] && command cp -i pm "${destination}/pm"

echo -e "${GREEN}✓${WHITE} pm is ready to use"
