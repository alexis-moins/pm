local space="${args[--space]}"
local name="${args[--name]}"

local backend="${args[--backend]}"

if [[ -n "${backend}" ]]; then
    # Path to the current backend
    export BACKEND_PATH="$(find_backend "${backend}")"
fi

if [[ -z "${space}" ]] && [[ -z "${name}" ]]; then
    local path="${args[path]:-"$(filter_projects)"}"

    if [[ -z "${path}" ]]; then
        exit 1
    fi

    space="$(dirname "${path}")"
    name="$(basename "${path}")"
fi

if ! project_exists "${space}" "${name}"; then
    error "no project '${name}' in space '${space}'"
    exit 1
fi

# Export variable that will be usable within the backend script
export SPACE="${space}"
export SPACE_PATH="${PM_HOME}/${space}"

export PROJECT="${name}"
export PROJECT_PATH="${PM_HOME}/${space}/${name}"

source "${BACKEND_PATH}"
