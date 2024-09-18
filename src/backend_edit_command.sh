local backend_name="${args[backend]}"

local backend="$(find_backend "${backend_name}")"

command ${EDITOR:-vim} "${backend}"
