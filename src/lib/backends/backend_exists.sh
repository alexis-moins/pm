backend_exists() {
    if [[ -f "${PM_DATA_DIR}/backends/${1}.sh" ]] || [[ -f "${HOME}/.config/pm/backends/${1}.sh" ]]; then
        return 0
    else
        return 1
    fi
}
