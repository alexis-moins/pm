list_backends_by_group() {
    # List 'user' backends first
    if [[ -z "${1}" ]] || [[ "${1}" = "user" ]]; then
        for file in $(command ls "${HOME}/.config/pm/backends"); do
            echo "${file/.sh/}"; done
    fi

    # Then list 'default' backends
    if [[ -z "${1}" ]] || [[ "${1}" = "default" ]]; then
        for file in $(command ls "${PM_DATA_DIR}/backends"); do
            echo "${file/.sh/}"; done
    fi
}
