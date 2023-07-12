confirm() {
    local response=`gum input --prompt "${1} $(green "(yes|no)") " --placeholder ""`
    [[ "${response}" == "yes" ]] && return 0 || return 1
}

