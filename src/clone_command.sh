local repository="${args[repository]}"

local name="${args[--name]}"
local space="${args[--space]}"

if project_exists "${space}" "${name}"; then
    error "project '${name}' already exists in space '${space}'"
    exit 1
fi

local destination="${PM_HOME}/${space}/${name}"

command "${deps[git]}" clone "${repository}" "${destination}"
success "cloned project ${name} in space ${space}"
