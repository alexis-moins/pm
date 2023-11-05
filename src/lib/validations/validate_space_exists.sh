validate_space_exists() {
    [[ ! -d "${PM_HOME}/${1}" ]] && echo "${1} must be an existing space. See $(yellow_underlined pm space list)"
}
