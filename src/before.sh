[[ ! -d "${PM_HOME}" ]] && command mkdir -p "${PM_HOME}/default"
[[ ! -f "${PM_HOME}/spaces" ]] && echo "default" > "${PM_HOME}/spaces"
