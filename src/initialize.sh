dirs=(
    "${PM_HOME}"

    "${PM_DATA_DIR}/templates"
    "${PM_DATA_DIR}/backends"

    "${HOME}/.config/pm/templates"
    "${HOME}/.config/pm/backends"
)

#
# Create directories if not present
#
for destination in ${dirs[*]}; do
    if [[ ! -d "${destination}" ]]; then
        command mkdir -p "${destination}"
    fi
done
