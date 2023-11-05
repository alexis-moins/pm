#!/usr/bin/env bash
# This script was generated by bashly 1.1.1 (https://bashly.dannyb.co)
# Modifying it manually is not recommended

if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  printf "bash version 4 or higher is required\n" >&2
  exit 1
fi

version_command() {
  echo "$version"
}

pm_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm - Project manager built on top of tmux\n"
    echo

  else
    printf "pm - Project manager built on top of tmux\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm COMMAND\n"
  printf "  pm [COMMAND] --help | -h\n"
  printf "  pm --version | -v\n"
  echo

  printf "%s\n" "PROJECT Commands:"
  printf "  %s   Create a new empty project\n" "new  "
  printf "  %s   Clone a remote git repository\n" "clone"
  printf "  %s   Open a project in a tmux session\n" "open "
  echo
  printf "%s\n" "Commands:"
  printf "  %s   Create a symbolic link to the pm script\n" "link "
  printf "  %s   Show projects' root directory\n" "dir  "
  printf "  %s   Create, delete or list spaces\n" "space"
  printf "  %s   List project directories\n" "list "
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo
    printf "  %s\n" "--version, -v"
    printf "    Show version number\n"
    echo

    printf "%s\n" "Environment Variables:"

    printf "  %s\n" "PM_ROOT_DIR"
    printf "    Root directory used to manage projects\n"
    printf "    Default: ${HOME}/dev\n"
    echo

  fi
}

pm_new_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm new - Create a new empty project\n"
    echo

  else
    printf "pm new - Create a new empty project\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm new NAME [OPTIONS]\n"
  printf "  pm new --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--no-git, -n"
    printf "    Skip git repository initialization\n"
    echo

    printf "  %s\n" "--detach, -d"
    printf "    Don't attach to the new tmux session\n"
    echo

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "NAME"
    printf "    Name of the new project\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm new recipe --no-git\n"
    printf "  pm new personal/recipe --detach\n"
    echo

  fi
}

pm_clone_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm clone - Clone a remote git repository\n"
    echo

  else
    printf "pm clone - Clone a remote git repository\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm clone URL [DESTINATION]\n"
  printf "  pm clone --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "URL"
    printf "    URL of the remote repository\n"
    echo

    printf "  %s\n" "DESTINATION"
    printf "    Where to clone the project (relative to the PM_ROOT_DIR)\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm clone git@github.com:alexis-moins/portal.git\n"
    printf "  pm clone git@github.com:alexis-moins/portal.git personal/portal\n"
    echo

  fi
}

pm_open_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm open - Open a project in a tmux session\n"
    echo

  else
    printf "pm open - Open a project in a tmux session\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm open [NAME]\n"
  printf "  pm open --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "NAME"
    printf "    Name of the project\n"
    echo

  fi
}

pm_link_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm link - Create a symbolic link to the pm script\n"
    echo

  else
    printf "pm link - Create a symbolic link to the pm script\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm link [PATH] [OPTIONS]\n"
  printf "  pm link --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--remove, -r"
    printf "    Remove the symbolic link instead\n"
    echo

    printf "  %s\n" "--source, -s SOURCE"
    printf "    Path to the directory containing the pm script\n"
    printf "    Default: ${HOME}/.pm\n"
    echo

    printf "  %s\n" "--copy, -c"
    printf "    Copy the script instead of creating a symbolic link\n"
    echo

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "PATH"
    printf "    Path to the symbolic link\n"
    printf "    Default: ${HOME}/.local/bin\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm link /usr/local/bin\n"
    printf "  pm link --source ~/scripts/pm --remove\n"
    echo

  fi
}

pm_dir_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm dir - Show projects' root directory\n"
    echo

  else
    printf "pm dir - Show projects' root directory\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm dir\n"
  printf "  pm dir --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

  fi
}

pm_space_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm space - Create, delete or list spaces\n"
    echo

  else
    printf "pm space - Create, delete or list spaces\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm space COMMAND\n"
  printf "  pm space [COMMAND] --help | -h\n"
  echo

  printf "%s\n" "Commands:"
  printf "  %s   Add new spaces\n" "add   "
  printf "  %s   List registered spaces\n" "list  "
  printf "  %s   Remove a space. It does not remove projects for you\n" "remove"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

  fi
}

pm_space_add_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm space add - Add new spaces\n"
    echo

  else
    printf "pm space add - Add new spaces\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm space add DIRECTORIES...\n"
  printf "  pm space add --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    echo "  DIRECTORIES..."
    printf "    Directories to add as spaces\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm space add personal\n"
    printf "  pm space add school/first-year school/second-year\n"
    echo

  fi
}

pm_space_list_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm space list - List registered spaces\n"
    echo

  else
    printf "pm space list - List registered spaces\n"
    echo

  fi

  printf "Alias: ls\n"
  echo

  printf "%s\n" "Usage:"
  printf "  pm space list\n"
  printf "  pm space list --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm space ls\n"
    printf "  pm space list\n"
    echo

  fi
}

pm_space_remove_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm space remove - Remove a space. It does not remove projects for you\n"
    echo

  else
    printf "pm space remove - Remove a space. It does not remove projects for you\n"
    echo

  fi

  printf "Alias: rm\n"
  echo

  printf "%s\n" "Usage:"
  printf "  pm space remove [SPACE]\n"
  printf "  pm space remove --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "SPACE"
    printf "    Name of the space to remove\n"
    echo

  fi
}

pm_list_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm list - List project directories\n"
    echo

  else
    printf "pm list - List project directories\n"
    echo

  fi

  printf "Alias: ls\n"
  echo

  printf "%s\n" "Usage:"
  printf "  pm list SPACES...\n"
  printf "  pm list --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    echo "  SPACES..."
    printf "    Spaces to list projects from\n"
    echo

  fi
}

normalize_input() {
  local arg flags

  while [[ $# -gt 0 ]]; do
    arg="$1"
    if [[ $arg =~ ^(--[a-zA-Z0-9_\-]+)=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^(-[a-zA-Z0-9])=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^-([a-zA-Z0-9][a-zA-Z0-9]+)$ ]]; then
      flags="${BASH_REMATCH[1]}"
      for ((i = 0; i < ${#flags}; i++)); do
        input+=("-${flags:i:1}")
      done
    else
      input+=("$arg")
    fi

    shift
  done
}

inspect_args() {
  if ((${#args[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!args[@]}" | sort)
    echo args:
    for k in "${sorted_keys[@]}"; do echo "- \${args[$k]} = ${args[$k]}"; done
  else
    echo args: none
  fi

  if ((${#other_args[@]})); then
    echo
    echo other_args:
    echo "- \${other_args[*]} = ${other_args[*]}"
    for i in "${!other_args[@]}"; do
      echo "- \${other_args[$i]} = ${other_args[$i]}"
    done
  fi

  if ((${#deps[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!deps[@]}" | sort)
    echo
    echo deps:
    for k in "${sorted_keys[@]}"; do echo "- \${deps[$k]} = ${deps[$k]}"; done
  fi

}

print_in_color() {
  local color="$1"
  shift
  if [[ -z ${NO_COLOR+x} ]]; then
    printf "$color%b\e[0m\n" "$*"
  else
    printf "%b\n" "$*"
  fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
yellow() { print_in_color "\e[33m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
magenta() { print_in_color "\e[35m" "$*"; }
cyan() { print_in_color "\e[36m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
underlined() { print_in_color "\e[4m" "$*"; }
red_bold() { print_in_color "\e[1;31m" "$*"; }
green_bold() { print_in_color "\e[1;32m" "$*"; }
yellow_bold() { print_in_color "\e[1;33m" "$*"; }
blue_bold() { print_in_color "\e[1;34m" "$*"; }
magenta_bold() { print_in_color "\e[1;35m" "$*"; }
cyan_bold() { print_in_color "\e[1;36m" "$*"; }
red_underlined() { print_in_color "\e[4;31m" "$*"; }
green_underlined() { print_in_color "\e[4;32m" "$*"; }
yellow_underlined() { print_in_color "\e[4;33m" "$*"; }
blue_underlined() { print_in_color "\e[4;34m" "$*"; }
magenta_underlined() { print_in_color "\e[4;35m" "$*"; }
cyan_underlined() { print_in_color "\e[4;36m" "$*"; }

confirm() {
    local response=`gum choose --header "${1}" --header.foreground="7" --cursor.foreground="4" 'yes' 'no'`
    [[ "${response}" == "yes" ]] && return 0 || return 1
}

filter_project() {
    command fd --type d --max-depth 1 --base-directory "${PM_ROOT_DIR}" . $(cat "${PM_ROOT_DIR}/spaces") | sort --unique | \
        gum filter --placeholder "Select a project"
}

filter_space() {
    command cat "${PM_ROOT_DIR}/spaces" | gum filter --placeholder "${1}"
}

run_silent() {
  command ${@} &> /dev/null
}

pm_new_command() {
  local project="${args[name]}"

  space="$(filter_space 'Select project space:')"

  [[ -z "${space}" ]] && exit 1

  project="${space}/${project}"
  echo "Project space: $(magenta ${space})"

  local path="${PM_ROOT_DIR}/${project}"

  if [[ -d "${path}" ]]; then
      echo "$(red pm:) project already exists"
      exit 1
  fi

  \mkdir -p "${path}"

  if confirm "Init git repository?"; then
      pushd "${path}" &> /dev/null
      \git init &> /dev/null

      echo "Init git repository? $(magenta yes)"
  else
      echo "Init git repository? $(magenta no)"
  fi

  local name=`basename "${path}" | sed 's/\./dot-/'`

  if [[ -z "${TMUX}" ]]; then
      # Outside tmux session
      tmux new-session -c "${path}" -s "${name}"
  else
      # Inside tmux session
      tmux new-session -c "${path}" -d -s "${name}"
      tmux switch-client -t "${name}"
  fi

  echo -e "\n$(green ✔) Project created"

}

pm_clone_command() {
  local url="${args[url]}"
  local destination="${args[destination]}"

  if [[ -z "${destination}" ]]; then
      local prompt='Project destination: '
      destination=`gum input --prompt "${prompt}" --placeholder 'work/awesome-project' --value "$(basename ${url})"`
      echo "${prompt}$(cyan ${destination})"
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

  command git clone "git@github.com:${url}" "$project_name"
  echo "$(green ✔) Cloned project in $(magenta ${destination})"

}

pm_open_command() {
  local project="${args[name]:-$(filter_project)}"

  [[ -z "${project}" ]] && exit 1

  local path="${PM_ROOT_DIR}/${project}"
  local name=`basename "${path}" | sed 's/\./dot-/'`

  local session=`tmux list-windows -aF '#S: #{pane_current_path}' | \
      uniq | command rg "${name}: ${path::-1}"`

  if [[ -z "${TMUX}" ]]; then
      # Outside tmux session
      if [[ -z "${session}" ]]; then
          tmux new-session -c $path -s "${name}"
      else
          tmux attach -t "${name}"
      fi
  else
      # Inside tmux session
      if [[ -z "${session}" ]]; then
          tmux new-session -c $path -d -s "${name}"
          tmux switch-client -t "${name}"
      else
          tmux switch-client -t "${name}"
      fi
  fi

}

pm_link_command() {
  local path="${args[path]}"

  local source="${args[--source]}"
  local remove="${args[--remove]}"
  local copy="${args[--copy]}"

  if [[ -n "${remove}" ]]; then
      if [[ -f "${path}/pm" ]]; then
          run_silent rm -rf "${path}/pm"
          echo "$(green ✔) Link removed from $(magenta "${path}")"
      else
          echo "$(red pm:) no link found in $(magenta "${path}")"
          exit 1
      fi
  else
      if [[ -f "${path}/pm" ]]; then
          echo "$(red pm:) there is already a link in $(magenta "${path}")"
          exit 1
      fi

      if [[ ! -d "${source}" ]]; then
          echo "$(red pm:) source directory $(magenta "${source}") does not exist"
          exit 1
      fi

      source=`realpath "${source}"`

      if [[ ! -f "${source}/pm" ]]; then
          echo "$(red pm:) script 'pm' not found in $(magenta "${source}")"
          exit 1
      fi

      local executable=`test -n "${copy}" && echo "cp" || echo "ln -s"`

      run_silent ${executable} "${source}/pm" "${path}/pm"
      echo "$(green ✔) Link created in $(magenta "${path}")"
  fi

}

pm_dir_command() {
  echo "${PM_ROOT_DIR}"

}

pm_space_add_command() {
  local spaces_index="${PM_ROOT_DIR}/spaces"

  for space in ${other_args[*]}; do
      # Create the space if it does not exist yet
      [[ ! -d "${PM_ROOT_DIR}/${space}" ]] && command mkdir -p "${PM_ROOT_DIR}/${space}" &> /dev/null

      echo "${space}" >> "${spaces_index}"
  done

  \sort --unique "${spaces_index}" --output "${spaces_index}"
  echo "$(green ✔) New space(s) added"

}

pm_space_list_command() {
  if [[ -f "${PM_ROOT_DIR}/spaces" ]]; then
      cat "${PM_ROOT_DIR}/spaces"
  fi

}

pm_space_remove_command() {
  local space="${args[space]:-$(filter_space 'Select a space to remove...')}"

  local new_spaces=`command rg -vN --color=never "${space}" "${PM_ROOT_DIR}/spaces"`

  echo "${new_spaces}" > "${PM_ROOT_DIR}/spaces"
  echo "$(yellow Note:) pm does not remove projects. Remove them manually"
  echo "$(green ✔) Space removed from index"

}

pm_list_command() {
  command fd --type d --max-depth 1 --base-directory "${PM_ROOT_DIR}" . ${other_args[*]} | sort --unique

}

parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --version | -v)
        version_command
        exit
        ;;

      --help | -h)
        long_usage=yes
        pm_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  export PM_ROOT_DIR="${PM_ROOT_DIR:-${HOME}/dev}"

  if command -v git >/dev/null 2>&1; then
    deps['git']="$(command -v git | head -n1)"
  else
    printf "missing dependency: git\n" >&2
    exit 1
  fi

  if command -v tmux >/dev/null 2>&1; then
    deps['tmux']="$(command -v tmux | head -n1)"
  else
    printf "missing dependency: tmux\n" >&2
    exit 1
  fi

  if command -v fd >/dev/null 2>&1; then
    deps['fd']="$(command -v fd | head -n1)"
  else
    printf "missing dependency: fd\n" >&2
    exit 1
  fi

  if command -v gum >/dev/null 2>&1; then
    deps['gum']="$(command -v gum | head -n1)"
  else
    printf "missing dependency: gum\n" >&2
    exit 1
  fi

  if command -v rg >/dev/null 2>&1; then
    deps['rg']="$(command -v rg | head -n1)"
  else
    printf "missing dependency: rg\n" >&2
    exit 1
  fi

  action=${1:-}

  case $action in
    -*) ;;

    new)
      action="new"
      shift
      pm_new_parse_requirements "$@"
      shift $#
      ;;

    clone)
      action="clone"
      shift
      pm_clone_parse_requirements "$@"
      shift $#
      ;;

    open)
      action="open"
      shift
      pm_open_parse_requirements "$@"
      shift $#
      ;;

    link)
      action="link"
      shift
      pm_link_parse_requirements "$@"
      shift $#
      ;;

    dir)
      action="dir"
      shift
      pm_dir_parse_requirements "$@"
      shift $#
      ;;

    space)
      action="space"
      shift
      pm_space_parse_requirements "$@"
      shift $#
      ;;

    list | ls)
      action="list"
      shift
      pm_list_parse_requirements "$@"
      shift $#
      ;;

    "")
      pm_usage >&2
      exit 1
      ;;

    *)
      printf "invalid command: %s\n" "$action" >&2
      exit 1
      ;;

  esac

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

pm_new_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_new_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="new"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      --no-git | -n)

        args['--no-git']=1
        shift
        ;;

      --detach | -d)

        args['--detach']=1
        shift
        ;;

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['name']+x} ]]; then

          args['name']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  if [[ -z ${args['name']+x} ]]; then
    printf "missing required argument: NAME\nusage: pm new NAME [OPTIONS]\n" >&2
    exit 1
  fi

}

pm_clone_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_clone_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="clone"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['url']+x} ]]; then

          args['url']=$1
          shift
        elif [[ -z ${args['destination']+x} ]]; then

          args['destination']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  if [[ -z ${args['url']+x} ]]; then
    printf "missing required argument: URL\nusage: pm clone URL [DESTINATION]\n" >&2
    exit 1
  fi

}

pm_open_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_open_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="open"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['name']+x} ]]; then

          args['name']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

}

pm_link_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_link_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="link"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      --remove | -r)

        args['--remove']=1
        shift
        ;;

      --source | -s)

        if [[ -n ${2+x} ]]; then

          args['--source']="$2"
          shift
          shift
        else
          printf "%s\n" "--source requires an argument: --source, -s SOURCE" >&2
          exit 1
        fi
        ;;

      --copy | -c)

        args['--copy']=1
        shift
        ;;

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['path']+x} ]]; then

          args['path']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  [[ -n ${args['path']:-} ]] || args['path']="${HOME}/.local/bin"
  [[ -n ${args['--source']:-} ]] || args['--source']="${HOME}/.pm"

}

pm_dir_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_dir_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="dir"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

pm_space_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_space_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action=${1:-}

  case $action in
    -*) ;;

    add)
      action="add"
      shift
      pm_space_add_parse_requirements "$@"
      shift $#
      ;;

    list | ls)
      action="list"
      shift
      pm_space_list_parse_requirements "$@"
      shift $#
      ;;

    remove | rm)
      action="remove"
      shift
      pm_space_remove_parse_requirements "$@"
      shift $#
      ;;

    "")
      pm_space_usage >&2
      exit 1
      ;;

    *)
      printf "invalid command: %s\n" "$action" >&2
      exit 1
      ;;

  esac

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

pm_space_add_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_space_add_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="space add"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      --)
        shift
        other_args+=("$@")
        break
        ;;

      -?*)
        other_args+=("$1")
        shift
        ;;

      *)

        other_args+=("$1")
        shift

        ;;

    esac
  done

  if [[ ${#other_args[@]} -eq 0 ]]; then
    printf "missing required argument: DIRECTORIES...\nusage: pm space add DIRECTORIES...\n" >&2
    exit 1
  fi

}

pm_space_list_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_space_list_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="space list"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

pm_space_remove_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_space_remove_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="space remove"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)

        if [[ -z ${args['space']+x} ]]; then

          args['space']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

}

pm_list_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_list_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="list"

  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      --)
        shift
        other_args+=("$@")
        break
        ;;

      -?*)
        other_args+=("$1")
        shift
        ;;

      *)

        other_args+=("$1")
        shift

        ;;

    esac
  done

  if [[ ${#other_args[@]} -eq 0 ]]; then
    printf "missing required argument: SPACES...\nusage: pm list SPACES...\n" >&2
    exit 1
  fi

}

initialize() {
  version="1.0.0"
  long_usage=''
  set -e

  export PM_ROOT_DIR="${PM_ROOT_DIR:-${HOME}/dev}"

}

run() {
  declare -A args=()
  declare -A deps=()
  declare -a other_args=()
  declare -a input=()
  normalize_input "$@"
  parse_requirements "${input[@]}"

  case "$action" in
    "new") pm_new_command ;;
    "clone") pm_clone_command ;;
    "open") pm_open_command ;;
    "link") pm_link_command ;;
    "dir") pm_dir_command ;;
    "space") pm_space_command ;;
    "space add") pm_space_add_command ;;
    "space list") pm_space_list_command ;;
    "space remove") pm_space_remove_command ;;
    "list") pm_list_command ;;
  esac
}

initialize
run "$@"
