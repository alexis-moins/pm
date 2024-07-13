export SPACE_INDEX="${PM_HOME}/spaces"

[[ ! -d "${PM_HOME}" ]] && command mkdir -p "${PM_HOME}"
[[ ! -f "${SPACE_INDEX}" ]] && touch "${SPACE_INDEX}"

# Create directories if not present
for space in $(cat "${SPACE_INDEX}"); do
    [[ ! -d "${PM_HOME}/${space}" ]] && command mkdir -p "${PM_HOME}/${space}"
done

command sort --unique "${SPACE_INDEX}" --output "${SPACE_INDEX}"
