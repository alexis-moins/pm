<div align='center'>

![Version](https://img.shields.io/badge/version-1.8.3-blue.svg)

</div>

`pm` is a bash script allowing users to rapidly list, create and navigate between your projects. It integrate with different backends (tmux, vscode) for convenience.

## Prerequisites

- bash 4.0 or higher
- [gum](https://github.com/charmbracelet/gum)
- tmux (optional)
- git


## 🧰 Installation

Clone the repository
```bash
git clone git@github.com:alexis-moins/pm.git ~/.pm
```

Go into the install directory and execute the [install](install.sh) script:
```bash
./install.sh
```

The install script copies the `pm` script in the `~/.local/bin` directory (you can also change the destination by passing it as an argument to the install script).

## 🌱 Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Add a new space
pm space add personal

# You can then create new projects in this space
pm new -s personal -n react-app

# pm supports project creation using templates
pm new -s personal -n react-app -t vite

# But also creating your own one
pm template new python-poetry

# Opening a project is simple
pm open personal/react-app

# But using a different backend is also possible
pm open -s personal -n react-app -b vscode

# You can even clone github repositories directly
pm clone git@github.com:alexis-moins/dot.git --space=work --name=dot
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
  completions      Generate bash completions
  cd               Open pm home in a new shell
  space            Add, list and filter spaces
  template         Template related commands
  backend          Backend related commands

Project Commands:
  new              Create a new empty project
  clone            Clone a remote git repository
  open             Open a project
  filter           Filter projects
  list             List projects

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

  PM_BACKEND_SHOW_CMD
    Command used to show backends
    Default: cat

  PM_TEMPLATE_SHOW_CMD
    Command used to show templates
    Default: cat
```
