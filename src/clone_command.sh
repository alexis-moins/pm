local url="${args[url]}"
local name="${args[name]}"

if [[ -d "${PM_ROOT_DIR}/${name}" ]]; then
    echo "$(red pm:) destination already contains this project"
    exit 1
fi

pushd "${PM_ROOT_DIR}/${root}" &> /dev/null

command git clone "${url}" ${name}
echo "$(green ✔) Added project"
