<div align='center'>

```
  _ __  _ __ ___
 | '_ \| '_ ` _ \
 | |_) | | | | | |
 | .__/|_| |_| |_|
 | |
 |_|
```

![Version](https://img.shields.io/badge/version-1.3.0-blue.svg)

</div>

---

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

The last command creates a symbolic link to the `pm` script in the `~/.local/bin/` directory (you can also change the link destination path). Finally, if you did not clone the repository in `~/.pm`, run the don't forget to set the `PM_INSTALL_DIR` environment variable globally afterwards!

### Manually

Clone the repository then move the [pm](pm) script to anywhere in your `PATH`, and ensure it is executable!

## 🛎️ Setup

Finally, copy the templates used by pm to create new projects.
```bash
# Create the 'pm' configuration directory
mkdir -p ~/.config/pm

# Copy templates provided by default
copy -r ~/.pm/templates ~/.config/pm/
```

## 🌱 Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Add a new space (a 'default' space is setup by pm for you)
pm space add personal

# You can then create new projects in this space
pm new portal --space personal

# Opening the project is even simpler
pm open portal --space personal

# You can even clone github repositories directly
pm clone alexis-moins/portfolio --space work
```

## ✏️  Tmux integration

`pm` suggests the following keybinding to easily open projects from tmux. You can put them at the end of your `~/.tmux.conf`.
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
  space    Create, delete or list spaces
  link     Create a link to the recipe script
  unlink   Remove the link to the recipe script
  update   Update to the latest version
  env      Show environment information

Project Commands:
  new      Create a new empty project
  clone    Clone a remote git repository
  open     Open a project in a tmux session
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
```
