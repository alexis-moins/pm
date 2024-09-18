space_exists() {
    [[ -d "${PM_HOME}/${1}" ]] && return 0 || return 1
}
