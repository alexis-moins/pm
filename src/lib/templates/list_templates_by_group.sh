list_templates_by_group() {
    # List 'user' templates first
    if [[ -z "${1}" ]] || [[ "${1}" = "user" ]]; then
        for file in $(command ls "${HOME}/.config/pm/templates"); do
            echo "${file/.sh/}"; done
    fi

    # Then list 'default' templates
    if [[ -z "${1}" ]] || [[ "${1}" = "default" ]]; then
        for file in $(command ls "${PM_DATA_DIR}/templates"); do
            echo "${file/.sh/}"; done
    fi
}
