local path="${args[path]}"
local copy="${args[--copy]}"
local remove="${args[--remove]}"

if [[ -n "${remove}" ]]; then
    if [[ -f "${path}/pm" ]]; then
        run_silent rm -rf "${path}/pm"
        echo "$(green ✔) Link removed from $(magenta "${path}")"
    else
        echo "No link found in $(magenta "${path}")"
        exit 1
    fi
else
    if [[ -f "${path}/pm" ]]; then
        echo "There is already a link in $(magenta "${path}")"
        exit 1
    fi

    if [[ ! -d "${PM_INSTALL}" ]]; then
        echo "Source directory $(magenta "${PM_INSTALL}") does not exist"
        exit 1
    fi

    if [[ ! -f "${PM_INSTALL}/pm" ]]; then
        echo "Script 'pm' not found in $(magenta "${PM_INSTALL}")"
        exit 1
    fi

    local executable=`test -n "${copy}" && echo "cp" || echo "ln -s"`

    run_silent ${executable} "${PM_INSTALL}/pm" "${path}/pm"
    echo "$(green ✔) Link created in $(magenta "${path}")"
fi
