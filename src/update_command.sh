if [[ ! -d "${PM_INSTALL_DIR}" ]]; then
    warn "no pm install directory."
    warn "check documentation for installation instruction."
    exit 1
fi

git -C "${PM_INSTALL_DIR}" pull
