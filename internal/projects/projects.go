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

func Create(space, project string, template []templates.Step) error {
	path := GetPath(space, project)

	for _, step := range template {
		step.Subsitute(space, project, path)
		cmd := step.GetCommand(space, path)

		fmt.Printf("%s %s\n", styles.Red.Render("*"), strings.Join(step.Command, " "))

		if output, err := cmd.CombinedOutput(); err != nil {
			return errors.New(string(output))
		} else if len(output) > 0 {
			fmt.Println(styles.Grey.Render(string(output)[:]))
		}
	}

	return nil
}

// Clone the repository in the given space, using the given project name.
func Clone(repository, space, projectName string) (string, error) {
	command := exec.Command("git", "clone", fmt.Sprintf("git@github.com:%s.git", repository), GetPath(space, projectName))

	output, err := command.CombinedOutput()
	return string(output), err
}
