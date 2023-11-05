local space="${args[space]:-$(filter_space 'Select a space to remove...')}"

local new_spaces=`command rg -vN --color=never "${space}" "${PM_ROOT_DIR}/spaces"`

echo "${new_spaces}" > "${PM_ROOT_DIR}/spaces"
echo "$(yellow Note:) pm does not remove projects. Remove them manually"
echo "$(green ✔) Space removed from index"
