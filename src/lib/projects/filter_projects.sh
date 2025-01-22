filter_projects() {
    list_projects | command "${deps[gum]}" filter --placeholder="Filter projects"
}
