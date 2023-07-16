local project="${args[name]}"

if [[ -z "${project}" ]]; then
    local prompt="Project name: "
    project=`gum input --prompt "${prompt}" --placeholder 'awesome-cli'`

    [[ -z "${project}" ]] && exit 1
    echo "${prompt}$(blue ${project})"
fi

if [[ -f "${PM_ROOT_DIR}/spaces" ]] && ! confirm "Use default space?"; then
    space=`cat "${PM_ROOT_DIR}/spaces" | gum choose --header 'Select a project space:' --header.foreground='7' --cursor.foreground='4'`

    [[ -z "${space}" ]] && exit 1

    project="${space}/${project}"
    echo "Project space: $(blue ${space})"
else
    echo "Project space: $(blue default)"
fi

local path="${PM_ROOT_DIR}/${project}"

if [[ -d "${path}" ]]; then
    echo "$(red np:) project already exists"
    exit 1
fi

command mkdir -p "${path}"

if confirm "Init git repository?"; then
    pushd "${path}" &> /dev/null
    command git init &> /dev/null

    echo "Init git repository: $(blue yes)"
else
    echo "Init git repository: $(blue no)"
fi

local name=`basename "${path}" | sed 's/\./dot-/'`

if [[ -z "${TMUX}" ]]; then
    # Outside tmux session
    tmux new-session -c "${path}" -s "${name}"
else
    # Inside tmux session
    tmux new-session -c "${path}" -d -s "${name}"
    tmux switch-client -t "${name}"
fi
