filter_project() {
    list_projects | command "${deps[gum]}" filter --placeholder "Select a project"
}
