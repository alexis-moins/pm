<div align='center'>

```
                  
                  
  _ __  _ __ ___  
 | '_ \| '_ ` _ \ 
 | |_) | | | | | |
 | .__/|_| |_| |_|
 | |              
 |_|              
```

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)

</div>

---

`pm` is a bash script allowing users to:
- Rapidly create new local projects (using `$PM_ROOT_DIR` as the root of all projects)
- Navigate between these projects using tmux

## Prerequisites

- bash 4.0 or higher
- [gum](https://github.com/charmbracelet/gum)
- [fd](https://github.com/sharkdp/fd)
- tmux
- git


## Installation

### Using pm

```bash
# Clone the repository in the recommended location
git clone git@github.com:alexis-moins/pm.git ~/.pm

# Let pm create the symbolic link for you!
cd ~/.pm && ./pm link
```

The last command creates a symbolic link to the `pm` script in the `~/.local/bin/` directory. If you cloned the repository elsewhere, you may pass the repository path to the link command using the `-s | --source` flag. Likewise, you can also change the link destination path with the optional `path` argument!
```bash
./pm link /usr/local/bin/ --source ~/scritps/pm
```

### Manually

Clone the repository then move the [pm](pm) script to `~/.local/bin/` or anywhere in your `PATH`, and make it executable.

## Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Create a new project, you will be taken there automatically
pm new

# You can specify a name right away (sub-directories will be created for you)
pm new personal/portal

# Fuzzy find a project to switch to using tmux
pm switch

# You can even clone github repositories
pm clone git@github.com:alexis-moins/recipe
```

## Tmux integration

It is recommended that you place the following configuration inside your `~/.tmux.conf` file.
```
# Open a project in a new session
bind-key o display-popup -E "pm open"

# Create a new project and navigate there
bind-key - display-popup -E "pm new"
```

You should now be able to:
- Create new projects using `<prefix> + -`
- Quickly open a project with `<prefix> + o`.

## Usage

```
$ pm

pm - Local project manager

Usage:
  pm COMMAND
  pm [COMMAND] --help | -h
  pm --version | -v

Commands:
  new      Create a new empty project
  clone    Clone a remote git repository
  switch   Switch to a project
  link     Create a symbolic link to the pm script

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  PM_ROOT_DIR
    Root directory used to manage projects
    Default: ~/dev

  PM_MAX_DEPTH
    Maximum depth to display sub-directories
    Default: 2
```

