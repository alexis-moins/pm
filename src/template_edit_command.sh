local template_name="${args[template]}"

local template="$(find_template "${template_name}")"

command ${EDITOR:-vim} "${template}"
