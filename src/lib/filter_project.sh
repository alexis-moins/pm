filter_project() {
    fd --type d --max-depth 1 --base-directory "${PM_ROOT_DIR}" . $(cat "${PM_ROOT_DIR}/spaces") | \
        gum filter --placeholder "Select a project"
}
