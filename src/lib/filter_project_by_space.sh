filter_project_by_space() {
    command find "${PM_HOME}/${1}" -maxdepth 1 -mindepth 1 -type d \
        | sed "s!${PM_HOME}/!!" \
        | command "${deps[gum]}" filter --placeholder "Select a project"
}
