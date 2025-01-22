local backend_name="${args[backend]:-"$(filter_backends)"}"

if ! backend_exists "${backend_name}"; then
    exit 1
fi

local backend="$(find_backend "${backend_name}")"

command ${EDITOR:-vim} "${backend}"
