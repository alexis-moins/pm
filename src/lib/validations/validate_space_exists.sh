validate_space_exists() {
    if ! space_exists "${1}"; then
        error "space not found: ${1}"
    fi
}
