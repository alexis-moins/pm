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
  printf "  %s   Create a new empty project\n" "new   "
  printf "  %s   Clone a remote git repository\n" "clone "
  printf "  %s   Open a project in a tmux session\n" "open  "
  printf "  %s   Filter projects by name\n" "filter"
  printf "  %s   List projects\n" "list  "
  echo
  printf "%s\n" "SCRIPT Commands:"
  printf "  %s   Show projects' root directory\n" "dir   "
  printf "  %s   Create a link to this script\n" "link  "
  printf "  %s   Update to the latest version\n" "update"
  echo
  printf "%s\n" "Commands:"
  printf "  %s   Create, delete or list spaces\n" "space "
  printf "  %s   Commands for tmux integration\n" "tmux  "
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

    printf "  %s\n" "PM_INSTALL"
    printf "    Directory where the repository was cloned\n"
    printf "    Default: ${HOME}/.pm\n"
    echo

    printf "  %s\n" "PM_HOME"
    printf "    Directory where the projects will be managed\n"
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

    printf "  %s\n" "--space, -s SPACE"
    printf "    Space of the new project\n"
    printf "    Default: default\n"
    echo

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
    printf "  pm new recipe --detach\n"
    printf "  pm new recipe --space=tools --no-git\n"
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
  printf "  pm clone REPOSITORY [DESTINATION]\n"
  printf "  pm clone --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "REPOSITORY"
    printf "    Remote repository to clone (FORMAT: <username>/<repository>)\n"
    echo

    printf "  %s\n" "DESTINATION"
    printf "    Where to clone the project (relative to ${PM_HOME})\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm clone alexis-moins/portal\n"
    printf "  pm clone alexis-moins/portal personal/portal\n"
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
  printf "  pm open NAME\n"
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

    printf "%s\n" "Examples:"
    printf "  pm open school/elixir-api\n"
    echo

  fi
}

pm_filter_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm filter - Filter projects by name\n"
    echo

  else
    printf "pm filter - Filter projects by name\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm filter\n"
  printf "  pm filter --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm filter\n"
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

    printf "%s\n" "Examples:"
    printf "  pm dir\n"
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
  printf "  %s   Remove a space (projects will not be removed)\n" "remove"
  printf "  %s   Filter spaces by name\n" "filter"
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
    printf "pm space remove - Remove a space (projects will not be removed)\n"
    echo

  else
    printf "pm space remove - Remove a space (projects will not be removed)\n"
    echo

  fi

  printf "Alias: rm\n"
  echo

  printf "%s\n" "Usage:"
  printf "  pm space remove SPACE\n"
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

    printf "%s\n" "Examples:"
    printf "  pm space rm personal\n"
    printf "  pm space remove school/first-year\n"
    echo

  fi
}

pm_space_filter_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm space filter - Filter spaces by name\n"
    echo

  else
    printf "pm space filter - Filter spaces by name\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm space filter\n"
  printf "  pm space filter --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm space filter\n"
    echo

  fi
}

pm_list_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm list - List projects\n"
    echo

  else
    printf "pm list - List projects\n"
    echo

  fi

  printf "Alias: ls\n"
  echo

  printf "%s\n" "Usage:"
  printf "  pm list\n"
  printf "  pm list --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm ls\n"
    printf "  pm list\n"
    echo

  fi
}

pm_link_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm link - Create a link to this script\n"
    echo

  else
    printf "pm link - Create a link to this script\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm link [PATH] [OPTIONS]\n"
  printf "  pm link --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--copy, -c"
    printf "    Copy the script instead of creating a symbolic link\n"
    echo

    printf "  %s\n" "--remove, -r"
    printf "    Remove the link instead of creating it\n"
    echo

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Arguments:"

    printf "  %s\n" "PATH"
    printf "    Path to the link\n"
    printf "    Default: ${HOME}/.local/bin\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm link --remove\n"
    printf "  pm link /usr/local/bin\n"
    echo

  fi
}

pm_update_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm update - Update to the latest version\n"
    echo

  else
    printf "pm update - Update to the latest version\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm update\n"
  printf "  pm update --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm update\n"
    echo

  fi
}

pm_tmux_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm tmux - Commands for tmux integration\n"
    echo

  else
    printf "pm tmux - Commands for tmux integration\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm tmux COMMAND\n"
  printf "  pm tmux [COMMAND] --help | -h\n"
  echo

  printf "%s\n" "Commands:"
  printf "  %s   Create a new empty project\n" "new        "
  printf "  %s   Open a project in a tmux session\n" "open       "
  printf "  %s   Print tmux keybindings\n" "keybindings"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

  fi
}

pm_tmux_new_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm tmux new - Create a new empty project\n"
    echo

  else
    printf "pm tmux new - Create a new empty project\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm tmux new\n"
  printf "  pm tmux new --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm tmux new\n"
    echo

  fi
}

pm_tmux_open_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm tmux open - Open a project in a tmux session\n"
    echo

  else
    printf "pm tmux open - Open a project in a tmux session\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm tmux open\n"
  printf "  pm tmux open --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm tmux open\n"
    echo

  fi
}

pm_tmux_keybindings_usage() {
  if [[ -n $long_usage ]]; then
    printf "pm tmux keybindings - Print tmux keybindings\n"
    echo

  else
    printf "pm tmux keybindings - Print tmux keybindings\n"
    echo

  fi

  printf "%s\n" "Usage:"
  printf "  pm tmux keybindings\n"
  printf "  pm tmux keybindings --help | -h\n"
  echo

  if [[ -n $long_usage ]]; then
    printf "%s\n" "Options:"

    printf "  %s\n" "--help, -h"
    printf "    Show this help\n"
    echo

    printf "%s\n" "Examples:"
    printf "  pm tmux keybindings\n"
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
    command fd --type d --max-depth 1 --base-directory "${PM_HOME}" . $(cat "${PM_HOME}/spaces") | sort --unique | \
        gum filter --placeholder "Select a project"
}

filter_space() {
    command cat "${PM_HOME}/spaces" | gum filter --placeholder "Select a space"
}

filter_recipe_book_healthy() {
    if ! recipe_doctor_command &> /dev/null; then
        echo "$(yellow info:) your recipe book is not correctly setup"
        echo "$(yellow info:) consider running $(yellow_underlined recipe doctor)"
    fi
}

run_silent() {
  command ${@} &> /dev/null
}

validate_dir_exists() {
  [[ -d "$1" ]] || echo "must be an existing directory"
}

validate_file_exists() {
  [[ -f "$1" ]] || echo "must be an existing file"
}

validate_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] || echo "must be an integer"
}

validate_not_empty() {
  [[ -z "$1" ]] && echo "must not be empty"
}

validate_space_exists() {
    [[ ! -d "${PM_HOME}/${1}" ]] && echo "${1} must be an existing space. See $(yellow_underlined pm space list)"
}

pm_new_command() {
  local name="${args[name]}"
  local space="${args[--space]}"

  local detach="${args[--detach]}"
  local no_git="${args[--no-git]}"

  project="${space}/${name}"

  local path="${PM_HOME}/${project}"

  if [[ -d "${path}" ]]; then
      echo "$(red pm:) project already exists"
      exit 1
  fi

  \mkdir -p "${path}"

  if [[ -z "${no_git}" ]]; then
      pushd "${path}" &> /dev/null
      \git init &> /dev/null
  fi

  local name=`basename "${path}" | sed 's/\./dot-/'`

  if [[ -n "${detach}" ]]; then
      echo "$(green ✔) Project $(magenta ${name}) created in $(magenta_underlined ${space})"
      exit 0
  fi

  if [[ -z "${TMUX}" ]]; then
      # Outside tmux session
      tmux new-session -c "${path}" -s "${name}"
  else
      # Inside tmux session
      tmux new-session -c "${path}" -d -s "${name}"
      tmux switch-client -t "${name}"
  fi

  echo "$(green ✔) Project $(magenta ${name}) created in $(magenta_underlined ${space}) space"

}

pm_clone_command() {
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

}

pm_open_command() {
  local project="${args[name]}"

  local path="${PM_HOME}/${project}"
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

pm_filter_command() {
  filter_project

}

pm_dir_command() {
  echo "${PM_HOME}"

}

pm_space_add_command() {
  local spaces_index="${PM_HOME}/spaces"

  for space in ${other_args[*]}; do
      # Create the space if it does not exist yet
      [[ ! -d "${PM_HOME}/${space}" ]] && command mkdir -p "${PM_HOME}/${space}" &> /dev/null

      echo "${space}" >> "${spaces_index}"
  done

  \sort --unique "${spaces_index}" --output "${spaces_index}"
  echo "$(green ✔) New space(s) added"

}

pm_space_list_command() {
  if [[ -f "${PM_HOME}/spaces" ]]; then
      cat "${PM_HOME}/spaces"
  fi

}

pm_space_remove_command() {
  local space="${args[space]:-$(filter_space 'Select a space to remove...')}"

  local new_spaces=`command rg -vN --color=never "${space}" "${PM_HOME}/spaces"`

  echo "${new_spaces}" > "${PM_HOME}/spaces"
  echo "$(yellow Note:) pm does not remove projects. Remove them manually"
  echo "$(green ✔) Space removed from index"

}

pm_space_filter_command() {
  filter_space

}

pm_list_command() {
  command fd --type d --max-depth 1 --base-directory "${PM_HOME}" . $(cat "${PM_HOME}/spaces") | sort --unique

}

pm_link_command() {
  local path="${args[path]}"
  local copy="${args[--copy]}"
  local remove="${args[--remove]}"

  if [[ -n "${remove}" ]]; then
      if [[ -f "${path}/pm" ]]; then
          run_silent rm -rf "${path}/pm"
          echo "$(green ✔) Link removed from $(magenta "${path}")"
      else
          echo "No link found in $(magenta "${path}")"
          exit 1
      fi
  else
      if [[ -f "${path}/pm" ]]; then
          echo "There is already a link in $(magenta "${path}")"
          exit 1
      fi

      if [[ ! -d "${PM_INSTALL}" ]]; then
          echo "Source directory $(magenta "${PM_INSTALL}") does not exist"
          exit 1
      fi

      if [[ ! -f "${PM_INSTALL}/pm" ]]; then
          echo "Script 'pm' not found in $(magenta "${PM_INSTALL}")"
          exit 1
      fi

      local executable=`test -n "${copy}" && echo "cp" || echo "ln -s"`

      run_silent ${executable} "${PM_INSTALL}/pm" "${path}/pm"
      echo "$(green ✔) Link created in $(magenta "${path}")"
  fi

}

pm_update_command() {
  if [[ ! -d "${PM_INSTALL}" ]]; then
      echo "${PM_INSTALL} is not a directory. Check documentation for installation instruction."
      exit 1
  fi

  git -C "${PM_INSTALL}" pull

}

pm_tmux_new_command() {
  local prompt="Project name: "
  project=`gum input --prompt "${prompt}" --placeholder 'awesome-cli'`

  [[ -z "${project}" ]] && exit 1
  echo "${prompt}$(blue ${project})"

  space="$(filter_space)"
  [[ -z "${space}" ]] && exit 1

  project="${space}/${project}"
  echo "Project space: $(blue ${space})"

  local path="${PM_HOME}/${project}"

  if [[ -d "${path}" ]]; then
      echo "$(red np:) project already exists"
      exit 1
  fi

  command mkdir -p "${path}"

  if confirm "Init git repository?"; then
      pushd "${path}" &> /dev/null
      command git init &> /dev/null
      echo "Init git repository: $(blue yes)"
  else
      echo "Init git repository: $(blue no)"
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

  echo "$(green ✔) Project $(magenta ${name}) created in $(magenta_underlined ${space}) space"

}

pm_tmux_open_command() {
  local project="$(filter_project)"

  [[ -z "${project}" ]] && exit 1

  local path="${PM_HOME}/${project}"
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

pm_tmux_keybindings_command() {
  echo "# Leader + o: open a pm project"
  echo 'bind-key o display-popup -E "pm tmux open"'

  echo -e "\n# Leader + -: create a new pm project"
  echo 'bind-key - display-popup -E "pm tmux new"'

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

  export PM_INSTALL="${PM_INSTALL:-${HOME}/.pm}"
  export PM_HOME="${PM_HOME:-${HOME}/dev}"

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

    filter)
      action="filter"
      shift
      pm_filter_parse_requirements "$@"
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

    link)
      action="link"
      shift
      pm_link_parse_requirements "$@"
      shift $#
      ;;

    update)
      action="update"
      shift
      pm_update_parse_requirements "$@"
      shift $#
      ;;

    tmux)
      action="tmux"
      shift
      pm_tmux_parse_requirements "$@"
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

      --space | -s)

        if [[ -n ${2+x} ]]; then

          if [[ -n $(validate_space_exists "$2") ]]; then
            printf "validation error in %s:\n%s\n" "--space, -s SPACE" "$(validate_space_exists "$2")" >&2
            exit 1
          fi

          args['--space']="$2"
          shift
          shift
        else
          printf "%s\n" "--space requires an argument: --space, -s SPACE" >&2
          exit 1
        fi
        ;;

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

  [[ -n ${args['--space']:-} ]] || args['--space']="default"

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

        if [[ -z ${args['repository']+x} ]]; then

          args['repository']=$1
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

  if [[ -z ${args['repository']+x} ]]; then
    printf "missing required argument: REPOSITORY\nusage: pm clone REPOSITORY [DESTINATION]\n" >&2
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

  if [[ -z ${args['name']+x} ]]; then
    printf "missing required argument: NAME\nusage: pm open NAME\n" >&2
    exit 1
  fi

}

pm_filter_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_filter_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="filter"

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

    filter)
      action="filter"
      shift
      pm_space_filter_parse_requirements "$@"
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

  if [[ -z ${args['space']+x} ]]; then
    printf "missing required argument: SPACE\nusage: pm space remove SPACE\n" >&2
    exit 1
  fi

}

pm_space_filter_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_space_filter_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="space filter"

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

      --copy | -c)

        if [[ -n "${args['--remove']:-}" ]]; then
          printf "conflicting options: %s cannot be used with %s\n" "$key" "--remove" >&2
          exit 1
        fi

        args['--copy']=1
        shift
        ;;

      --remove | -r)

        if [[ -n "${args['--copy']:-}" ]]; then
          printf "conflicting options: %s cannot be used with %s\n" "$key" "--copy" >&2
          exit 1
        fi

        args['--remove']=1
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

}

pm_update_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_update_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="update"

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

pm_tmux_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_tmux_usage
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

    new)
      action="new"
      shift
      pm_tmux_new_parse_requirements "$@"
      shift $#
      ;;

    open)
      action="open"
      shift
      pm_tmux_open_parse_requirements "$@"
      shift $#
      ;;

    keybindings)
      action="keybindings"
      shift
      pm_tmux_keybindings_parse_requirements "$@"
      shift $#
      ;;

    "")
      pm_tmux_usage >&2
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

pm_tmux_new_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_tmux_new_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="tmux new"

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

pm_tmux_open_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_tmux_open_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="tmux open"

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

pm_tmux_keybindings_parse_requirements() {

  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        pm_tmux_keybindings_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  action="tmux keybindings"

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

initialize() {
  version="0.1.0"
  long_usage=''
  set -e

  export PM_INSTALL="${PM_INSTALL:-${HOME}/.pm}"
  export PM_HOME="${PM_HOME:-${HOME}/dev}"

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
    "filter") pm_filter_command ;;
    "dir") pm_dir_command ;;
    "space") pm_space_command ;;
    "space add") pm_space_add_command ;;
    "space list") pm_space_list_command ;;
    "space remove") pm_space_remove_command ;;
    "space filter") pm_space_filter_command ;;
    "list") pm_list_command ;;
    "link") pm_link_command ;;
    "update") pm_update_command ;;
    "tmux") pm_tmux_command ;;
    "tmux new") pm_tmux_new_command ;;
    "tmux open") pm_tmux_open_command ;;
    "tmux keybindings") pm_tmux_keybindings_command ;;
  esac
}

initialize
run "$@"
