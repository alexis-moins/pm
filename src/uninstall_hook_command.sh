if [[ -d "${PM_DATA_DIR}/backends" ]]; then
    command rm -rf "${PM_DATA_DIR}/backends"
fi

if [[ -d "${PM_DATA_DIR}/templates" ]]; then
    command rm -rf "${PM_DATA_DIR}/templates"
fi
