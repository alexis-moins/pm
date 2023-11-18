local value="${args[value]}"
local path="${args[--path]}"

local project=`command fd --type d --max-depth 1 --base-directory "${PM_HOME}" . $(cat "${PM_HOME}/spaces") | sort --unique | \
    gum filter --placeholder "Select a project" --value "${value}"`

[[ -z "${project}" ]] && exit 1

[[ -n "${path}" ]] && project="${PM_HOME}/${project}"

echo "${project}"
