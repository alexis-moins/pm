local template_name="${args[template]:-"$(filter_templates)"}"

if ! template_exists "${template_name}"; then
    exit 1
fi

local template="$(find_template "${template_name}")"

command ${EDITOR:-vim} "${template}"
