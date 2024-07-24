<div align='center'>

![Version](https://img.shields.io/badge/version-1.8.1-blue.svg)

</div>

`pm` is a bash script allowing users to rapidly list, create and navigate between your projects. It integrate with different backends (tmux, vscode) for convenience.

## Prerequisites

- bash 4.0 or higher
- [gum](https://github.com/charmbracelet/gum)
- tmux (optional)
- git


## 🧰 Installation

### Manually

Clone the repository
```bash
git clone git@github.com:alexis-moins/pm.git ~/.pm
```

Go into the install directory and execute the [install](install.sh) script:
```bash
./install.sh
```

The last command creates a symbolic link to the `pm` script in the `~/.local/bin/` directory (you can also change the link destination path by passing it as an argument to the install script).

## 🌱 Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Add a new space
pm space add personal

# You can then create new projects in this space
pm new <project> -s personal

# pm supports project creation using templates
pm new <project> -s personal -t cargo

# You can list templates...
pm template list

# ...and even create your own
pm template new python-poetry

# Opening a project is even simpler
pm open <project> -s personal

# But using a different backend is also possible
pm open <project> -s personal -b vscode

# You can even clone github repositories directly
pm clone git@github.com:alexis-moins/dot.git -s work
```

## 🚦 Usage

```
$ pm

pm - manage your projects the easy way

Usage:
  pm COMMAND
  pm [COMMAND] --help | -h
  pm --version | -v

Commands:
  help       Show help about a command
  space      Space related commands
  template   Template related commands
  cd         Navigate to your pm home in a new shell

Project Commands:
  new        Create a new empty project
  clone      Clone a remote git repository
  open       Open a project
  list       List projects

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  PM_HOME
    Directory where the projects will be managed
    Default: ~/dev

  PM_BACKEND
    Name of the backend used to open projects
    Default: tmux

  PM_SHOW_CMD
    Command used to show templates
    Default: cat
```
