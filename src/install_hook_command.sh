[[ ! -d "${PM_DATA_DIR}" ]] && command mkdir -p "${PM_DATA_DIR}"

command cp -R ./backends "${PM_DATA_DIR}/backends"
command cp -R ./templates "${PM_DATA_DIR}/templates"
