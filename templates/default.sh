# Arguments:
#  1 - space name
#  2 - project name
#  3 - full path to the project
#
command mkdir -p "${3}"

git -C "${3}" init