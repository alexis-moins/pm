command fd --type d --max-depth 1 --base-directory "${PM_ROOT_DIR}" . $(cat "${PM_ROOT_DIR}/spaces") | sort --unique
