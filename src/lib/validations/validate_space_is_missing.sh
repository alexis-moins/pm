validate_space_is_missing() {
    if command grep "${1}" "${PM_HOME}/spaces" &> /dev/null; then
        error "space already exists: ${1}"
    fi
}
