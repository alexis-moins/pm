local name="${args[name]}"
local space="${args[--space]}"

local backend_name="${args[--backend]}"

if [[ -z "${name}" ]]; then
    if [[ -z "${space}" ]]; then
        project="$(filter_project)"
    else
        project="$(filter_project_by_space "${space}")"
    fi

    name="$(basename "${project}")"
    space="$(dirname "${project}")"
else
    if [[ "${name}" = */* ]]; then
        # NOTE: order matters here
        space="$(dirname "${name}")"
        name="$(basename "${name}")"

    elif [[ -z "${space}" ]]; then
        error "must use --space flag with argumet NAME"
        exit 1
    fi
fi

if ! project_exists "${space}" "${name}"; then
    error "no project '${name}' in space '${space}'"
    exit 1
fi

# Search for user backend first
local backend="${HOME}/.config/pm/backends/${backend_name}.sh"

if [[ ! -f "${backend}" ]]; then
    # Then search for pm backends
    backend="${PM_INSTALL_DIR}/backends/${backend_name}.sh"

    if [[ ! -f "${backend}" ]]; then
        error "backend '${backend_name}' not found"
        return 1
    fi
fi

local path="${PM_HOME}/${space}/${name}"

source "${backend}" "${space}" "${name}" "${path}"
