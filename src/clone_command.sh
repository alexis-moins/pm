local repository="${args[repository]}"

local name="${args[--name]}"
local space="${args[--space]}"

[[ -z "${name}" ]] && name=`basename "${repository}"`

if [[ -d "${PM_HOME}/${destination}/${name}" ]]; then
    echo "$(red pm:) destination already contains this project"
    exit 1
fi

local destination="${PM_HOME}/${space}/${name}"

command git clone "git@github.com:${repository}.git" "$destination"
echo "$(green ✔) Cloned project in space $(magenta ${space}) as $(magenta ${name})"
