local project="${args[name]}"
local silent="${args[--silent]}"

if [[ -z "${project}" ]]; then
    project=`gum input --prompt 'Name of the project: '`
fi

local path="${PM_ROOT_DIR}/${project}"

if [[ -d "${path}" ]]; then
    echo "$(red np:) project already exists"
    exit 1
fi

command mkdir -p "${path}"

if confirm "Initialize git repository?"; then
    pushd "${path}" &> /dev/null
    command git init &> /dev/null
fi

[[ -z "${silent}" ]] && echo "$(green ✔) Created new project"

local name=`basename "${path}" | sed 's/\./dot-/'`

if [[ -z "${TMUX}" ]]; then
    # Outside tmux session
    tmux new-session -c "${path}" -s "${name}"
else
    # Inside tmux session
    tmux new-session -c "${path}" -d -s "${name}"
    tmux switch-client -t "${name}"
fi
