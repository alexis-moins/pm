template_exists() {
    [[ ! -f "${PM_DATA_DIR}/templates/${1}.sh" ]] && [[ ! -f "${HOME}/.config/pm/templates/${1}.sh" ]] && return 1 || return 0
}
