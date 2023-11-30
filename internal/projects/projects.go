package projects

import (
	"fmt"
	"os"
	"os/exec"
	"path"
	"slices"

	_spaces "github.com/alexis-moins/pm/internal/spaces"
	"github.com/spf13/viper"
)

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

// Return the list of projects in all registered spaces.
func ListAllProjects() map[string][]string {
	spaces := viper.GetStringSlice("spaces")
	projects := map[string][]string{}

	for _, space := range spaces {
		key := projects[space]

		entries, err := os.ReadDir(_spaces.GetPath(space))

		if err != nil {
			continue
		}

		for _, file := range entries {
			if file.IsDir() && !slices.Contains(spaces, path.Join(space, file.Name())) {
				key = append(key, file.Name())
			}
		}

		projects[space] = key
	}

	return projects
}

func ListProjectsPorcelain() []string {
	spaces := viper.GetStringSlice("spaces")
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

func Create(space, project string) error {
	path := GetPath(space, project)

	if err := os.Mkdir(path, 0750); err != nil {
		return err
	}

	return nil
}

// Initialize a new empty git repository in the recipe book.
func InitGitRepository(path string) (string, error) {
	output, err := exec.Command("git", "-C", path, "init").CombinedOutput()
	return string(output), err
}
