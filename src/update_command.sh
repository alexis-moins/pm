if [[ ! -d "${PM_INSTALL_DIR}" ]]; then
    warn "no pm install directory."
    warn "check documentation for installation instruction."
    exit 1
fi

command "${deps[git]}" -C "${PM_INSTALL_DIR}" pull
