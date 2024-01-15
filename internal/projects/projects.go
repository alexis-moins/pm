package projects

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path"
	"regexp"
	"slices"
	"strings"

	_spaces "github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/alexis-moins/pm/internal/templates"
	"github.com/alexis-moins/pm/internal/tmux"
	"github.com/spf13/viper"
)

var shortFormatRegex = regexp.MustCompile(`^.+/.+$`)

// IsInShortFormat returns true if the given format follows the short format
// convention which is 'spaceName/projectName'.
func IsInShortFormat(format string) bool {
	return shortFormatRegex.Match([]byte(format))
}

// ParseShortFormat parses the given short format and return the space and the project name.
func ParseShortFormat(format string) (string, string) {
	return path.Dir(format), path.Base(format)
}

// Return true if the given project exists on the
// given space (corresponds to an existing directory).
func Exists(space, project string) bool {
	projectPath := GetPath(space, project)

	info, err := os.Stat(projectPath)

	if err != nil {
		return false
	}

	if info.IsDir() {
		return true
	}

	return false
}

// Return the full path to the project on the given space.
func GetPath(space, project string) string {
	return path.Join(_spaces.GetPath(space), project)
}

func ListProjectsInSpace(space string, addPrefix bool) []string {
	spaces := viper.GetStringSlice("spaces.list")

	projects := []string{}
	entries, err := os.ReadDir(_spaces.GetPath(space))

	if err != nil {
		return []string{}
	}

	for _, file := range entries {
		if file.IsDir() && !slices.Contains(spaces, path.Join(space, file.Name())) {
			entry := file.Name()

			if addPrefix {
				entry = space + "/" + entry
			}

			projects = append(projects, entry)
		}
	}

	return projects
}

func ListProjects() []string {
	spaces := viper.GetStringSlice("spaces.list")
	projects := []string{}

	for _, space := range spaces {
		entries, err := os.ReadDir(_spaces.GetPath(space))

		if err != nil {
			continue
		}

		for _, file := range entries {
			if file.IsDir() && !slices.Contains(spaces, path.Join(space, file.Name())) {
				projects = append(projects, fmt.Sprintf("%s/%s", space, file.Name()))
			}
		}
	}

	return projects
}

// Clone the repository in the given space, using the given project name.
func Clone(repository, space, projectName string) error {
	command := exec.Command("git", "clone", fmt.Sprintf("git@github.com:%s.git", repository), GetPath(space, projectName))

	fmt.Printf("%s %s %s\n", styles.Get("success").Render("*"),
		strings.Join(command.Args, " "), styles.Get("comment").Render("(this may take a while)"))

	output, err := command.CombinedOutput()

	if err != nil {
		return errors.New(string(output))
	}

	fmt.Println(styles.Get("comment").Render(string(output)))
	return nil
}

// Open opens the project in tmux (if configured) and execute custom hook.
func Open(space, project string) error {
	path := GetPath(space, project)
	useTmux := viper.GetBool("commands.open.tmux")

	if useTmux {
		if err := tmux.OpenProject(space, project, path); err != nil {
			return err
		}
	}

	steps, err := templates.FromConfig("commands.open.hook")

	if err != nil {
		return err
	}

	if len(steps) == 0 && !useTmux {
        fmt.Println("nothing to do...")
        return nil
	}

	err = templates.Run(steps, space, project, path)

	if err != nil {
		return err
	}

	return nil
}
