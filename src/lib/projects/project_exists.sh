project_exists() {
    [[ -d "${PM_HOME}/${1}/${2}" ]] && return 0 || return 1
}
