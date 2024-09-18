local path="${args[path]}"

local space="${args[--space]}"
local name="${args[--name]}"

local backend_name="${args[--backend]}"

if [[ -z "${space}" ]] && [[ -z "${name}" ]]; then
    if [[ -z "${path}" ]]; then
        error "missing required argument: PATH"
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

source "$(find_backend "${backend_name}")"
