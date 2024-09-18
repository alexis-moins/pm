validate_space_exists() {
    if ! space_exists "${1}"; then
        error "space '${1}' not found"
    fi
}
