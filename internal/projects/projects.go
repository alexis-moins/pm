package projects

import (
	"os"
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

	spaces = append(spaces, viper.GetString("default"))

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
