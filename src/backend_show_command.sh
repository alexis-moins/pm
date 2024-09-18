local backend_name="${args[backend]}"
local command="${args[--exec]}"

local backend="$(find_backend "${backend_name}")"

command ${command} "${backend}"
