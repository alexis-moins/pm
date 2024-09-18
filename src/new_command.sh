local path="${args[path]}"

local name="${args[--name]}"
local space="${args[--space]}"

local template_name="${args[--template]}"
local backend_name="${args[--backend]}"

if [[ -z "${space}" ]] && [[ -z "${name}" ]]; then
    if [[ -z "${path}" ]]; then
        error "missing required argument: PATH"
        exit 1
    fi

    space="$(dirname "${path}")"

    if ! space_exists "${space}"; then
        error "'${space}' is not a valid space"
        exit 1
    fi

    name="$(basename "${path}")"
fi

if project_exists "${space}" "${name}"; then
    error "project '${name}' already exists in space '${space}'"
    exit 1
fi

# Export variable that will be usable within the template and backend scripts
export SPACE="${space}"
export SPACE_PATH="${PM_HOME}/${space}"

export PROJECT="${name}"
export PROJECT_PATH="${PM_HOME}/${space}/${name}"

# Both find_* functions exit on error so we can avoid checking result
local template="$(find_template "${template_name}")"
local backend="$(find_backend "${backend_name}")"

source "${template}"

if [[ "${?}" -eq 0 ]]; then
    success "project '${name}' created in space '${space}'"
else
    error "unable to create project"
    exit 1
fi

source "${backend}"
