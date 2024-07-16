list_templates() {
    for file in $(command ls "${PM_INSTALL_DIR}/templates"); do
        if [[ -f "${HOME}/.config/pm/templates/${file}" ]]; then
            continue
        fi

        echo "${file/.sh/}"
    done

    # Exit if not user templates directory
    [[ ! -d "${HOME}/.config/pm/templates" ]] && exit 0

    for file in $(command ls "${HOME}/.config/pm/templates"); do
        echo "${file/.sh/}"
    done
}

