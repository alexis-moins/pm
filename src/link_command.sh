local path="${args[path]}"

local source="${args[--source]}"
local remove="${args[--remove]}"
local copy="${args[--copy]}"

if [[ -n "${remove}" ]]; then
    if [[ -f "${path}/pm" ]]; then
        run_silent rm -rf "${path}/pm"
        echo "$(green ✔) Link removed from $(magenta "${path}")"
    else
        echo "$(pm:) no link found in $(magenta "${path}")"
        exit 1
    fi
else
    if [[ -f "${path}/pm" ]]; then
        echo "$(pm:) there is already a link in $(magenta "${path}")"
        exit 1
    fi

    if [[ ! -d "${source}" ]]; then
        echo "$(pm:) source directory $(magenta "${source}") does not exist"
        exit 1
    fi

    source=`realpath "${source}"`

    if [[ ! -f "${source}/pm" ]]; then
        echo "$(pm:) script 'pm' not found in $(magenta "${source}")"
        exit 1
    fi

    local executable=`test -n "${copy}" && echo "cp" || echo "ln -s"`

    run_silent ${executable} "${source}/pm" "${path}/pm"
    echo "$(green ✔) Link created in $(magenta "${path}")"
fi
