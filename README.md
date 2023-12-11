<div align='center'>

```
                  
                  
  _ __  _ __ ___  
 | '_ \| '_ ` _ \ 
 | |_) | | | | | |
 | .__/|_| |_| |_|
 | |              
 |_|              
```

![Version](https://img.shields.io/badge/version-0.4.0-blue.svg)

</div>

---

`pm` is a go cli allowing users to rapidly create new projects. It integrate with tmux to allow for a seemless navigation.

## Prerequisites

- go 1.21 or higher
- tmux
- git


## Installation
```bash
go install github.com/alexis-moins/pm@latest
```

## Quick Start

After installing, you can follow these steps to quickly see how it works:

```bash
# Add a new space (a 'default' space is setup by pm for you)
pm space add personal

# You can then create new projects in this space
pm new portal --space personal

# Opening the project is even simpler
pm open portal --space personal

# You can also specify a short format
pm open -S personal/portal

# You can even clone github repositories
pm clone alexis-moins/portfolio --space work
```

## Usage

```
$ pm

Project manager built on top of tmux

Usage:
  pm [command]

Project Commands:
  clone       Clone a remote git repository
  list        List projects
  new         Create a new empty project
  open        Open a project in a tmux session

Additional Commands:
  completion  Generate the autocompletion script for the specified shell
  dir         Show the path to the directory managed by pm
  help        Help about any command
  space       Create, delete and list spaces

Flags:
  -h, --help      help for pm
  -v, --version   version for pm
```
