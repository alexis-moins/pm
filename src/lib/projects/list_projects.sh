list_projects() {
    find "${PM_HOME}" -maxdepth 2 -mindepth 2 -type d ! -name '.*' \
        | sed "s!${PM_HOME}/!!"
}
