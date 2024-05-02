name="${2/\./dot-}"

local session="$(tmux list-windows -aF '#S: #{pane_current_path}' \
    | uniq \
    | command rg  "${name}: ${3::-1}")"

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

