# Arguments:
#  1 - space name
#  2 - project name
#  3 - full path to the project
#
cd "$(dirname "${3}")"

cargo new "${2}"
