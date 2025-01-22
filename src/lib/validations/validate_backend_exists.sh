validate_backend_exists() {
    if ! backend_exists "${1}"; then
        error "backend not found: ${1}"
    fi
}
