if [[ ! -d "${PM_DATA_DIR}" ]]; then
    command mkdir -p "${PM_DATA_DIR}"
fi

command cp -R backends/*.sh "${PM_DATA_DIR}/backends/"
command cp -R templates/*.sh "${PM_DATA_DIR}/templates/"
