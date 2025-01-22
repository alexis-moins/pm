filter_spaces() {
    list_spaces | command "${deps[gum]}" filter --placeholder "Filter spaces..."
}
