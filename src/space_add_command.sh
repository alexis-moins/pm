local space="${args[space]}"

[[ ! -d "${PM_HOME}/${space}" ]] && command mkdir -p "${PM_HOME}/${space}" &> /dev/null
echo "${space}" >> "${SPACE_INDEX}"

command sort --unique "${SPACE_INDEX}" --output "${SPACE_INDEX}"
success "new space added"
