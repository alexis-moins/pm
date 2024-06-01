validate_space_is_missing() {
    if command grep "${1}" "${PM_HOME}/spaces" &> /dev/null; then
        echo "${1} is already a registered space"
        echo -e "\nSee $(yellow_underlined pm space list)"
    fi
}
