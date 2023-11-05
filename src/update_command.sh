if [[ ! -d "${PM_INSTALL}" ]]; then
    echo "${PM_INSTALL} is not a directory. Check documentation for installation instruction."
    exit 1
fi

git -C "${PM_INSTALL}" pull
