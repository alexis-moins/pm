local space="${args[space]}"

local new_spaces=`command rg -vN --color=never "${space}" "${PM_HOME}/spaces"`

echo "${new_spaces}" > "${PM_HOME}/spaces"
success "space removed from index"
