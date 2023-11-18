local name="${args[name]}"
local space="${args[--space]}"

if [[ -z "${name}" ]]; then
    project=`filter_project_by_space "${space}"`

    name=`basename "${project}"`
    space=`dirname "${project}"`
fi

if ! project_exists "${space}" "${name}"; then
    echo "$(red pm:) no project $(magenta ${name}) in space $(magenta ${space})"
    exit 1
fi

local path="${PM_HOME}/${space}/${name}"

name="${name/\./dot-}"

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
