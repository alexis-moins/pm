# Information about the project are passed as arguments in the following way:
#
# $1 - Name of the space the project must be created in.
#
# $2 - name of the project. Once this script ends, the directory
#      ${HOME}/${PM_HOME}/${1}/${2} should have been created.
#
# $3 - absolute path to the project. It corresponds to the following
#      pattern evaluated: ${HOME}/${PM_HOME}/${1}/${2}.

# Create the project directory
command mkdir -p "${3}"

# Navigate to the space directory
command cd "${3}"

# Create a new python project
command python -m venv .venv

# Initialize git repository
command git init

# Ignore the newly created virtual env
echo .venv > .gitignore
