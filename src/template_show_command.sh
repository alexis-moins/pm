local template_name="${args[template]}"
#
# Search for user templates first
local template="${HOME}/.config/pm/templates/${template_name}.sh"

if [[ -f "${template}" ]]; then
    command "${PM_SHOW_CMD}" "${template}"
else
    command "${PM_SHOW_CMD}" "${PM_INSTALL_DIR}/templates/${template_name}.sh"
fi
