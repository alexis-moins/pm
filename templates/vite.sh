# Information about the project are passed as arguments in the following way:
#
# $1 - Name of the space the project must be created in.
#
# $2 - name of the project. Once this script ends, the directory
#      ${HOME}/${PM_HOME}/${1}/${2} should have been created.
#
# $3 - absolute path to the project. It corresponds to the following
#      pattern evaluated: ${HOME}/${PM_HOME}/${1}/${2}.

manager="${PM_VITE_CMD:-npm}"
template="${PM_VITE_TEMPLATE:-"vue-ts"}"

# Navigate to the space directory
command cd "$(dirname "${3}")"

if [[ "${manager}" = "npm" ]]; then
    command npm create vite@latest "${2}" -- --template=${template}
else
    command "${manager}" create vite "${2}" --template=${template}
fi

# Initialize git repository
command git -C "${3}" init
