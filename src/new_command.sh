local path="${args[path]}"

local name="${args[--name]}"
local space="${args[--space]}"

local template="${args[--template]}"
local backend="${args[--backend]}"

if [[ -n "${template}" ]]; then
    # Path to the current template
    export TEMPLATE_PATH="$(find_template "${template}")"
fi

if [[ -n "${backend}" ]]; then
    # Path to the current backend
    export BACKEND_PATH="$(find_backend "${backend}")"
fi

if [[ -z "${space}" ]] && [[ -z "${name}" ]]; then
    if [[ -z "${path}" ]]; then
        space="$(filter_spaces)"

        echo "Space to create the project in: $(green "${space}")"

        [[ -z "${space}" ]] && exit 1
        name=$(gum input --prompt="What is the name of the project? " --placeholder="project name" --no-show-help)

        [[ -z "${name}" ]] && exit 1
        echo "What is the name of the project: $(green "${name}")"
    else
        space="$(dirname "${path}")"

        if ! space_exists "${space}"; then
            error "'${space}' is not a valid space"
            exit 1
        fi

        name="$(basename "${path}")"
    fi
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

source "${TEMPLATE_PATH}"

if [[ "${?}" -eq 0 ]]; then
    success "project '${name}' created in space '${space}'"
else
    error "unable to create project"
    exit 1
fi

source "${BACKEND_PATH}"
