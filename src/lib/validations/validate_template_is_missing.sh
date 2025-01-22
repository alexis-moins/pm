validate_template_is_missing() {
    if [[ -f "${HOME}/.config/pm/templates/${1}.sh" ]]; then
        error "template already exists: ${1}"
    fi
}
