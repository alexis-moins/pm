package spaces

import (
	"os"
	"path"
	"slices"

	"github.com/spf13/viper"
)

// Return true if the given space is registred in the
// pm configuration file.
func IsRegistered(space string) bool {
	if space == viper.GetString("default_space") {
		return true
	}

	spaces := viper.GetStringSlice("spaces")
	return slices.Contains(spaces, space)
}

// Return true if the given space exists (corresponds
// to an existing directory).
func Exists(space string) bool {
	HOME := viper.GetString("HOME")
	info, err := os.Stat(path.Join(HOME, space))

	if err != nil {
		return false
	}

	if info.IsDir() {
		return true
	}

	return false
}

// Return true if the space exists on the file system and
// is registered.
func IsValid(space string) bool {
	return Exists(space) && IsRegistered(space)
}

// Add a space to the registered spaces.
func Add(space string) error {
	spaceList := viper.GetStringSlice("spaces")

	spaceList = append(spaceList, space)
	viper.Set("spaces", spaceList)

	return viper.WriteConfig()
}

// Remove a space from the registered spaces.
func Remove(space string) error {
	spaceList := viper.GetStringSlice("spaces")

	spaceList = slices.DeleteFunc(spaceList, func(_space string) bool {
		return _space == space
	})

	viper.Set("spaces", spaceList)
	return viper.WriteConfig()
}

// Return the full path to the space.
func GetPath(space string) string {
	HOME := viper.GetString("HOME")
	return path.Join(HOME, space)
}
