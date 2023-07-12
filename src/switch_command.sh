local project="${args[name]}"

if [[ -z "${project}" ]]; then
    pushd "${PM_ROOT_DIR}" &> /dev/null
    project=`fd --hidden --type d --max-depth ${PM_MAX_DEPTH} | gum filter --placeholder "Select a project"`
    popd &> /dev/null
fi

local path="${PM_ROOT_DIR}/${project}"
local name=`basename "${path}" | sed 's/\./dot-/'`

local session=`tmux list-windows -aF '#S: #{pane_current_path}' | \
    uniq | command rg "${name}: ${path::-1}"`

if [[ -z "${TMUX}" ]]; then
    # Outside tmux session
    if [[ -z "${session}" ]]; then
        tmux new-session -c $path -s "${name}"
    else
        tmux attach -t "${name}"
    fi
else
    # Inside tmux session
    if [[ -z "${session}" ]]; then
        tmux new-session -c $path -d -s "${name}"
        tmux switch-client -t "${name}"
    else
        tmux switch-client -t "${name}"
    fi
fi
