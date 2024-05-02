local name="${args[name]}"

local space="${args[--space]}"
local template_name="${args[--template]}"

local project="${space}/${name}"

local path="${PM_HOME}/${project}"

if [[ -d "${path}" ]]; then
    error "project '${name}' already exists in space '${space}'."
    exit 1
fi

# Search for user templates first
local template="${HOME}/.config/pm/templates/${template_name}.sh"

if [[ ! -f "${template}" ]]; then
    # Then search for pm templates
    template="${PM_INSTALL_DIR}/templates/${template_name}.sh"

    if [[ ! -f "${template}" ]]; then
        error "template '${template_name}' not found."
        return 1
    fi
fi

source "${template}" "${space}" "${name}" "${path}" &> /dev/null

if [[ "${?}" ]]; then
    info "project '${name}' created in space '${space}'."
else
    error "unable to create project."
fi

if [[ ! -f "${PM_BACKEND}" ]]; then
    error "backend '${PM_BACKEND}' not found."
    return 1
fi

source "${PM_BACKEND}" "${space}" "${name}" "${path}" &> /dev/null

