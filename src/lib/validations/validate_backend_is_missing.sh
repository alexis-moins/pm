validate_backend_is_missing() {
    if [[ -f "${HOME}/.config/pm/backends/${1}.sh" ]]; then
        error "backend '${1}' already exists"
    fi
}
