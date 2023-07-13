local url="${args[url]}"

local destination="${args[destination]}"
local no_ssh="${args[--no-ssh]}"


if [[ -z "${destination}" ]]; then
    local prompt='Project destination: '
    destination=`gum input --prompt "${prompt}" --placeholder 'work/awesome-project' --value "$(basename ${url})"`
    echo "${prompt}$(cyan ${destination})"
fi

if [[ -z "${no_ssh}" ]]; then
    url="git@github.com:${url}.git"
else
    url="https://github.com/${url}.git"
fi

if [[ -d "${PM_ROOT_DIR}/${destination}" ]]; then
    echo "$(red pm:) destination already contains this project"
    exit 1
fi

local project_name=`basename "${destination}"`

local project_dir=`dirname "${destination}"`
local destination_dir="${PM_ROOT_DIR}/${project_dir}"

[[ ! -d "${project_dir}" ]] && command mkdir -p "${destination_dir}"
pushd "${destination_dir}" &> /dev/null

command git clone "${url}" "$project_name"
echo "$(green ✔) Added project"
