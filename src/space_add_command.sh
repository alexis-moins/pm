local spaces_index="${PM_HOME}/spaces"

for space in ${other_args[*]}; do
    # Create the space if it does not exist yet
    [[ ! -d "${PM_HOME}/${space}" ]] && command mkdir -p "${PM_HOME}/${space}" &> /dev/null

    echo "${space}" >> "${spaces_index}"
done

\sort --unique "${spaces_index}" --output "${spaces_index}"
echo "$(green ✔) New space(s) added"
