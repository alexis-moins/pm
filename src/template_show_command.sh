local template_name="${args[template]}"
local command="${args[--exec]}"
#
# Search for user templates first
local template="${HOME}/.config/pm/templates/${template_name}.sh"

if [[ -f "${template}" ]]; then
    command ${command} "${template}"
else
    command ${command} "${PM_INSTALL_DIR}/templates/${template_name}.sh"
fi
