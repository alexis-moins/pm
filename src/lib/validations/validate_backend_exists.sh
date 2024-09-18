validate_backend_exists() {
    if [[ ! -f "${PM_DATA_DIR}/backends/${1}.sh" ]] && [[ ! -f "${HOME}/.config/pm/backends/${1}.sh" ]]; then
        error "backend '${1}' not found"
    fi
}
