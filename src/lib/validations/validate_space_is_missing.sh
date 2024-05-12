validate_space_is_missing() {
    if command "${deps[rg]}" --quiet "${1}" "${PM_HOME}/spaces"; then
        echo "${1} is already a registered space"
        echo -e "\nSee $(yellow_underlined pm space list)"
    fi
}
