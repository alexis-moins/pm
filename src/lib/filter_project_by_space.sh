filter_project_by_space() {
    command fd --type d --max-depth 1 --base-directory "${PM_HOME}" . "${1}" | sort --unique | \
        gum filter --placeholder "Select a project"
}
