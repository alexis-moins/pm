local template_name="${args[template]}"
local command="${args[--exec]}"

local template="$(find_template "${template_name}")"

command ${command} "${template}"
