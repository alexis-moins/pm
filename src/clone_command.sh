local repository="${args[repository]}"
local destination="${args[destination]}"

[[ -z "${destination}" ]] && destination="default/$(basename ${repository})"

if [[ -d "${PM_HOME}/${destination}" ]]; then
    echo "$(red pm:) destination already contains this project"
    exit 1
fi

local project_name=`basename "${destination}"`

local project_dir=`dirname "${destination}"`
local destination_dir="${PM_HOME}/${project_dir}"

[[ ! -d "${project_dir}" ]] && command mkdir -p "${destination_dir}"
pushd "${destination_dir}" &> /dev/null

command git clone "git@github.com:${repository}.git" "$project_name"
echo "$(green ✔) Cloned project in $(magenta ${destination})"
