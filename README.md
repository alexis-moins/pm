<div align='center'>

![Version](https://img.shields.io/badge/version-1.4.0-blue.svg)

</div>

`pm` is a bash script allowing users to rapidly create new projects. It integrate with tmux to allow for a seamless navigation.

## Prerequisites

- bash 4.0 or higher
- [gum](https://github.com/charmbracelet/gum)
- [fd](https://github.com/sharkdp/fd)
- tmux
- git


## 🧰 Installation

### Using pm

Clone the repository in the recommended location
```bash
git clone git@github.com:alexis-moins/pm.git ~/.pm
```

Go into the install directory and let pm take care of the rest!
```bash
PM_INSTALL_DIR=$(pwd) ./pm link
```

The last command creates a symbolic link to the `pm` script in the `~/.local/bin/` directory (you can also change the link destination path). 

> If you did not clone the repository in `~/.pm`, don't forget to set the `PM_INSTALL_DIR` environment variable globally afterwards!

### Manually

Clone the repository then move the [pm](pm) script to anywhere in your `PATH`, and ensure it is executable!

## 🌱 Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Add a new space
pm space add personal

# You can then create new projects in this space
pm new <project> --space personal

# pm supports project creation using templates
pm new <project> --space personal --template cargo

# Opening the project is even simpler
pm open <project> --space personal

# You can even clone github repositories directly
pm clone alexis-moins/portfolio --space work
```

## 🥘 Misc

### Tmux

You can put the following shortcut at the end of your `~/.tmux.conf` to open a project from tmux interactively.
```bash
# Leader + o: open a pm project
bind-key o display-popup -E "pm open"
```

## 🚦 Usage

```
$ pm

pm - Project manager built on top of tmux

Usage:
  pm COMMAND
  pm [COMMAND] --help | -h
  pm --version | -v

Commands:
  help     Show help about a command
  space    Space related commands
  link     Create a link to the recipe script
  unlink   Remove the link to the recipe script
  update   Update to the latest version
  env      Show environment information

Project Commands:
  new      Create a new empty project
  clone    Clone a remote git repository
  open     Open a project
  filter   Filter projects by name
  list     List projects

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  PM_INSTALL_DIR
    Directory where the repository was cloned
    Default: ~/.pm

  PM_HOME
    Directory where the projects will be managed
    Default: ~/dev

  PM_BACKEND
    Script executed to open the project
    Default: ~/.pm/backends/tmux.sh
```
