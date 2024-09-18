validate_project_is_missing() {
    if [[ ! "${1}" = */* ]] || [[ -d "${PM_HOME}/${1}" ]]; then
        error "project '${1}' already exist"
    fi
}
