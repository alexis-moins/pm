filter_backends() {
    local backends="$(list_backends_by_group "${1}")"

    if [[ -n "${backends}" ]]; then
        pipe "${backends}" | command "${deps[gum]}" filter --placeholder "Filter backends..."
    fi
}
