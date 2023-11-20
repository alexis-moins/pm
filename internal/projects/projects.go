package projects

import (
	"os"
	"path"

	"github.com/spf13/viper"
)

// Return true if the given project exists on the
// given space (corresponds to an existing directory).
func Exists(name string, space string) bool {
	projectPath := GetPath(name, space)

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
func GetPath(name string, space string) string {
	HOME := viper.GetString("HOME")
	return path.Join(HOME, space, name)
}
