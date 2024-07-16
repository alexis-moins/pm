local name="${args[name]}"
local space="${args[--space]}"

local template_name="${args[--template]}"
local backend_name="${args[--backend]}"

if [[ -z "${space}" ]]; then
    space="$(cat "${SPACE_INDEX}" | "${deps[gum]}" filter --placeholder "Select a space")"

    [[ -z "${space}" ]] && exit 1
fi

local project="${space}/${name}"

local path="${PM_HOME}/${project}"

if [[ -d "${path}" ]]; then
    error "project '${name}' already exists in space '${space}'"
    exit 1
fi

if [[ -z "${template_name}" ]]; then
    template_name="$(list_templates | "${deps[gum]}" filter --placeholder "Select a template")"

    [[ -z "${template_name}" ]] && exit 1
fi

# Search for user templates first
local template="${HOME}/.config/pm/templates/${template_name}.sh"

if [[ ! -f "${template}" ]]; then
    # Then search for pm templates
    template="${PM_INSTALL_DIR}/templates/${template_name}.sh"

    if [[ ! -f "${template}" ]]; then
        error "template '${template_name}' not found"
        exit 1
    fi
fi

if source "${template}" "${space}" "${name}" "${path}"; then
    success "project '${name}' created in space '${space}'"
else
    error "unable to create project"
    exit 1
fi

# Search for user backend first
local backend="${HOME}/.config/pm/backends/${backend_name}.sh"

if [[ ! -f "${backend}" ]]; then
    # Then search for pm backends
    backend="${PM_INSTALL_DIR}/backends/${backend_name}.sh"

    if [[ ! -f "${backend}" ]]; then
        error "backend '${backend_name}' not found"
        exit 1
    fi
fi

source "${backend}" "${space}" "${name}" "${path}"
