package spaces

import (
	"os"
	"slices"

	"github.com/alexis-moins/pm/internal/projects"
	"github.com/spf13/viper"
)

// Return true if the given space is registred in the
// pm configuration file.
func IsRegistered(space string) bool {
	if space == viper.GetString("default") {
		return true
	}

	spaces := viper.GetStringSlice("spaces")
	return slices.Contains(spaces, space)
}

// Return true if the given project exists on the
// given space (corresponds to an existing directory).
func Exists(name string, space string) bool {
	projectPath := projects.GetPath(name, space)

	info, err := os.Stat(projectPath)

	if err != nil {
		return false
	}

	if info.IsDir() {
		return false
	}

	return true
}
