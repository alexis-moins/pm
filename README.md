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
- Navigate between these projects using tmux with a set of keybindings

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
# First initialize your project root (~/dev by default)
pm init

# You can specify a name right away (sub-directories will be created for you)
pm new personal/portal

# Fuzzy find a project to open/switch to using tmux
pm open personal/portal

# You can even clone github repositories
pm clone alexis-moins/recipe tools/recipe

###
# First initialize a new recipe book
recipe init

# Or, if you already have a recipe book
recipe clone git@github.com:awesome-user/recipe-book

# You can add a recipe
recipe add Dockerfile docker/express-js

# View the list of your recipes
recipe list

# Check you recipe book at any time
recipe doctor

# Edit a recipe
recipe edit docker/express-js

# Even use a recipe in another project
recipe use docker/express-js Dockerfile

# Optionally, you can add a remote repository to sync your recipe book across devices
recipe git remote add origin git@github.com:awesome-user/recipe-book
```

## Tmux integration

`pm` comes with the following tmux keybindings. You will be asked to add them to your config when running `pm init` but you can also manually add them by running
```bash
pm tmux keybindings >> ~/.tmux.conf
```

You should now be able to:
- Create new projects using `<prefix> + -`
- Quickly open a project with `<prefix> + o`.

## Usage

```
$ pm

pm - Project manager built on top of tmux

Usage:
  pm COMMAND
  pm [COMMAND] --help | -h
  pm --version | -v

PROJECT Commands:
  new      Create a new empty project
  clone    Clone a remote git repository
  open     Open a project in a tmux session
  filter   Filter projects by name
  list     List projects

SCRIPT Commands:
  dir      Show projects' root directory
  link     Create a link to this script
  update   Update to the latest version

Commands:
  space    Create, delete or list spaces
  tmux     Commands for tmux integration

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  PM_ROOT_DIR
    Directory where the projects will be managed
    Default: ~/dev

  PM_INSTALL
    Directory where the repository was cloned
    Default: ~/.pm
```

