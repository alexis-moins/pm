local path="${args[--path]}"

local project="$(filter_project)"
[[ -z "${project}" ]] && exit 1

[[ -n "${path}" ]] && project="${PM_HOME}/${project}"

echo "${project}"
