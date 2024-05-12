filter_space() {
    command cat "${PM_HOME}/spaces" | command "${deps[gum]}" filter --placeholder "Select a space"
}
