local SPACE_INDEX="${PM_HOME}/spaces"

if [[ ! -d "${PM_HOME}" ]]; then
    command mkdir -p "${PM_HOME}"
fi

if [[ ! -d "${PM_HOME}/default" ]]; then
    command mkdir -p "${PM_HOME}/default"
fi

if [[ ! -f "${SPACE_INDEX}" ]]; then
    touch "${SPACE_INDEX}"
fi


echo "default" >> "${SPACE_INDEX}"
command sort --unique "${SPACE_INDEX}" --output "${SPACE_INDEX}"
