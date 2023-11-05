local prompt="Project name: "
project=`gum input --prompt "${prompt}" --placeholder 'awesome-cli'`

[[ -z "${project}" ]] && exit 1
echo "${prompt}$(blue ${project})"

space="$(filter_space)"
[[ -z "${space}" ]] && exit 1

project="${space}/${project}"
echo "Project space: $(blue ${space})"

local path="${PM_HOME}/${project}"

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

echo "$(green ✔) Project $(magenta ${name}) created in $(magenta_underlined ${space}) space"
