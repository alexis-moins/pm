validate_project_is_missing() {
    if [[ ! "${1}" = */* ]] || [[ -d "${PM_HOME}/${1}" ]]; then
        error "project already exists: ${1}"
    fi
}
