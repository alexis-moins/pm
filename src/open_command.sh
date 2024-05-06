local name="${args[name]}"
local space="${args[--space]}"

if [[ -z "${name}" ]]; then
    if [[ -z "${space}" ]]; then
        project="$(filter_project)"
    else
        project="$(filter_project_by_space "${space}")"
    fi

    name=`basename "${project}"`
    space=`dirname "${project}"`
else
    if [[ -z "${space}" ]]; then
        error "must use --space flag with argumet NAME."
        return 1
    fi
fi

if ! project_exists "${space}" "${name}"; then
    error "no project '${name}' in space '${space}'."
    exit 1
fi

if [[ ! -f "${PM_BACKEND}" ]]; then
    error "backend '${PM_BACKEND}' not found."
    return 1
fi

local path="${PM_HOME}/${space}/${name}"

source "${PM_BACKEND}" "${space}" "${name}" "${path}" &> /dev/null
