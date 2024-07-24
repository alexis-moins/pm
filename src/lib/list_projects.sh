list_projects() {
    for space in $(cat "${PM_DATA_DIR}/spaces"); do
        command find "${PM_HOME}/${space}" -maxdepth 1 -mindepth 1 -type d | sed "s!${PM_HOME}/!!"
    done
}
