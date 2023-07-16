local spaces_index="${PM_ROOT_DIR}/spaces"

for space in ${other_args[*]}; do
    # Create the space if it does not exist yet
    [[ ! -d "${PM_ROOT_DIR}/${space}" ]] && command mkdir -p "${PM_ROOT_DIR}/${space}" &> /dev/null

    echo "${space}" >> "${spaces_index}"
done

command sort --unique "${spaces_index}" --output "${spaces_index}"
