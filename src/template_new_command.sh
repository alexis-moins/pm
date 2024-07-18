local template_name="${args[template]}"

local pm_template="${PM_DATA_DIR}/templates/default.sh"

[[ ! -d "${HOME}/.config/pm/templates" ]] && command mkdir -p "${HOME}/.config/pm/templates"

local new_template_path="${HOME}/.config/pm/templates/${template_name}.sh"

command cp "${pm_template}" "${new_template_path}"

command "${EDITOR:-vim}" ${new_template_path}
