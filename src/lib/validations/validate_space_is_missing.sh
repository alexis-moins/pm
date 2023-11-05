validate_space_is_missing() {
    if [[ -d "${PM_HOME}/${1}" ]]; then
        echo "${1} is already a registered space"
        echo -e "\nSee $(yellow_underlined pm space list)"
    fi
}
