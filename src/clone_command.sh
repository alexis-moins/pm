local repository="${args[repository]}"

local name="${args[--name]}"
local space="${args[--space]}"

if [[ -d "${PM_HOME}/${destination}/${name}" ]]; then
    error "space '${space}' already contains this project"
    exit 1
fi

local destination="${PM_HOME}/${space}/${name}"

command "${deps[git]}" clone "${repository}" "${destination}"
success "cloned project ${name} in space ${space}"
