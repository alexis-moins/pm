local project="${args[name]}"

if [[ -z "${project}" ]]; then
    local prompt='Project name: '
    project=`gum input --prompt "${prompt}"  --placeholder 'work/awesme-project'`
    echo "${prompt}$(cyan ${project})"
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

    echo "Initialize git repository: $(cyan yes)"
else
    echo "Initialize git repository: $(cyan no)"
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
