filter_templates() {
    local templates="$(list_templates_by_group "${1}")"

    if [[ -n "${templates}" ]]; then
        pipe "${templates}" | command "${deps[gum]}" filter --placeholder="Filter templates"
    fi
}
