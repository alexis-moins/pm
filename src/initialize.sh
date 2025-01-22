# Define data dir here rather than in bashly.yaml to prevent users from
# changing it.
export PM_DATA_DIR="${HOME}/.local/share/pm"

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

# File used to store the name of the current template
export TEMPLATE_INDEX="${PM_DATA_DIR}/global-template"

# File used to store the name of the current backend
export BACKEND_INDEX="${PM_DATA_DIR}/global-backend"

template_name="$(cat "${TEMPLATE_INDEX}")"
backend_name="$(cat "${BACKEND_INDEX}")"

# Path to the current template
export TEMPLATE_PATH="$(find_template "${template_name}")"

# Path to the current backend
export BACKEND_PATH="$(find_backend "${backend_name}")"
