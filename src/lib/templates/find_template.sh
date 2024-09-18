find_template() {
    # Search for user templates first
    local template="${HOME}/.config/pm/templates/${1}.sh"

    if [[ ! -f "${template}" ]]; then
        # Then search for pm templates
        template="${PM_DATA_DIR}/templates/${1}.sh"

        if [[ ! -f "${template}" ]]; then
            error "template '${1}' not found"
            exit 1
        fi
    fi

    echo "${template}"
}
