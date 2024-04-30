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
local template="${HOME}/.config/${template_name}"

if [[ ! -f "${template}" ]]; then
    # Then search for pm templates
    template="${PM_INSTALL_DIR}/templates/${template_name}"

    if [[ ! -f "${template}" ]]; then
        error "template '${template_name}' not found."
        return 1
    fi
fi

source "${template}" "${space}" "${name}" "${path}"

if [[ -z "${TMUX}" ]]; then
    # Outside tmux session
    tmux new-session -c "${path}" -s "${name}"
else
    # Inside tmux session
    tmux new-session -c "${path}" -d -s "${name}"
    tmux switch-client -t "${name}"
fi

if [[ "${?}" ]]; then
    info "project '${name}' created in space '${space}'."
else
    error "unable to create project."
fi
