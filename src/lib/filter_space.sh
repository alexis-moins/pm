filter_space() {
    command cat "${PM_HOME}/spaces" | gum filter --placeholder "Select a space"
}
