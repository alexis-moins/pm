list_spaces() {
    find "${PM_HOME}" -maxdepth 1 -mindepth 1 -type d ! -name '.*' \
        | sed "s!${PM_HOME}/!!"
}
