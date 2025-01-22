validate_project_exists() {
    if [[ ! "${1}" = */* ]] || [[ ! -d "${PM_HOME}/${1}" ]]; then
        error "project not found: ${1}"
    fi
}
