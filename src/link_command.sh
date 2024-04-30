local path="${args[path]}"
local copy="${args[--copy]}"

local source="${PM_INSTALL_DIR}"

if [[ -f "${path}/pm" ]]; then
    error "there is already a link in ${path}."
    exit 1
fi

if [[ ! -d "${source}" ]]; then
    error "source directory ${source} does not exist."
    exit 1
fi

if [[ ! -f "${source}/pm" ]]; then
    error "script 'pm' not found in ${source}."
    exit 1
fi

local executable=`test -n "${copy}" && echo "cp" || echo "ln -s"`

command ${executable} "${source}/pm" "${path}/pm"
info "link created in ${path}."
