validate_space_exists() {
    if [[ ! -d "${PM_HOME}/${1}" ]]; then
        echo "${1} must be an existing space"
        echo -e "\nSee $(yellow_underlined pm space list)"
    fi
}
