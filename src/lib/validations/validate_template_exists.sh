validate_template_exists() {
    if [[ ! -f "${PM_INSTALL_DIR}/templates/${1}.sh" ]] && [[ ! -f "${HOME}/.config/pm/templates/${1}.sh" ]]; then
        error "template ${1} not found"
    fi
}
