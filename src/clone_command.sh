local repository="${args[repository]}"

local name="${args[--name]}"
local space="${args[--space]}"

if [[ -z "${name}" ]]; then
    name="$(command "${deps[gum]}" input --placeholder "awesome-project" --prompt "Project name: " --no-show-help)"

    [[ -z "${name}" ]] && exit 0
fi

if [[ -z "${space}" ]]; then
    space="$(cat "${SPACE_INDEX}" | "${deps[gum]}" filter --placeholder "Select a space")"

    [[ -z "${space}" ]] && exit 0
fi

if [[ -d "${PM_HOME}/${destination}/${name}" ]]; then
    error "space '${space}' already contains this project"
    exit 1
fi

local destination="${PM_HOME}/${space}/${name}"

command "${deps[git]}" clone "${repository}" "${destination}"
success "cloned project ${name} in space ${space}"
