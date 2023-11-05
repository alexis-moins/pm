local project="${args[name]}"

space="$(filter_space 'Select project space:')"

[[ -z "${space}" ]] && exit 1

project="${space}/${project}"
echo "Project space: $(magenta ${space})"

local path="${PM_ROOT_DIR}/${project}"

if [[ -d "${path}" ]]; then
    echo "$(red pm:) project already exists"
    exit 1
fi

\mkdir -p "${path}"

if confirm "Init git repository?"; then
    pushd "${path}" &> /dev/null
    \git init &> /dev/null

    echo "Init git repository? $(magenta yes)"
else
    echo "Init git repository? $(magenta no)"
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

echo -e "\n$(green ✔) Project created"
