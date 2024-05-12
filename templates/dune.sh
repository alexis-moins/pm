# Information about the project are passed as arguments in the following way:
#
# $1 - Name of the space the project must be created in.
#
# $2 - name of the project. Once this script ends, the directory
#      ${HOME}/${PM_HOME}/${1}/${2} should have been created.
#
# $3 - absolute path to the project. It corresponds to the following
#      pattern evaluated: ${HOME}/${PM_HOME}/${1}/${2}.

# Navigate to the space directory
command cd "$(dirname "${3}")"

# Create a new dune project
command dune init project "${2}"

# Initialize git repository
command git -C "${3}" init
#
# Ignore the _build directory
echo _build > .gitignore
