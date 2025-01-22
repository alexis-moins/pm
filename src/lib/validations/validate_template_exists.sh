validate_template_exists() {
    if ! template_exists "${1}"; then
        error "template not found: ${1}"
    fi
}
