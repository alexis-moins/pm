local variable="${args[variable]}"

if [[ -n "${variable}" ]]; then
    echo "${!variable}"
else
    echo "PM_INSTALL_DIR=${PM_INSTALL_DIR}"
    echo "PM_HOME=${PM_HOME}"
    echo "PM_BACKEND=${PM_BACKEND}"
fi

