filter_project() {
    command fd --type d --max-depth 1 --base-directory "${PM_HOME}" . $(cat "${PM_HOME}/spaces") | sort --unique | \
        gum filter --placeholder "Select a project"
}
