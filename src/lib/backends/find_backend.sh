find_backend() {
    # Search for user backend first
    local backend="${HOME}/.config/pm/backends/${1}.sh"

    if [[ ! -f "${backend}" ]]; then
        # Then search for pm backends
        backend="${PM_DATA_DIR}/backends/${1}.sh"

        if [[ ! -f "${backend}" ]]; then
            error "backend '${1}' not found"
            exit 1
        fi
    fi

    echo "${backend}"
}
