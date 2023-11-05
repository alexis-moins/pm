local name="${args[name]}"
local space="${args[--space]}"

local detach="${args[--detach]}"
local no_git="${args[--no-git]}"

project="${space}/${name}"

local path="${PM_HOME}/${project}"

if [[ -d "${path}" ]]; then
    echo "$(red pm:) project already exists"
    exit 1
fi

\mkdir -p "${path}"

if [[ -z "${no_git}" ]]; then
    pushd "${path}" &> /dev/null
    \git init &> /dev/null
fi

local name=`basename "${path}" | sed 's/\./dot-/'`

if [[ -n "${detach}" ]]; then
    echo "$(green ✔) Project $(magenta ${name}) created in $(magenta_underlined ${space})"
    exit 0
fi

if [[ -z "${TMUX}" ]]; then
    # Outside tmux session
    tmux new-session -c "${path}" -s "${name}"
else
    # Inside tmux session
    tmux new-session -c "${path}" -d -s "${name}"
    tmux switch-client -t "${name}"
fi

echo "$(green ✔) Project $(magenta ${name}) created in $(magenta_underlined ${space}) space"
