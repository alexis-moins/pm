package spaces

import (
	"errors"
	"fmt"
	"os"
	"path"
	"slices"

	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

func SpaceFlagCompletionFunc(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
	return viper.GetStringSlice("spaces.list"), cobra.ShellCompDirectiveNoFileComp
}

// Return true if the given space is registred in the
// pm configuration file.
func IsRegistered(space string) bool {
	if space == viper.GetString("spaces.default") {
		return true
	}

	spaces := viper.GetStringSlice("spaces.list")
	return slices.Contains(spaces, space)
}

// Return true if the given space exists (corresponds
// to an existing directory).
func Exists(space string) bool {
	HOME := viper.GetString("global.home")
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

func InvalidSpaceError(space string) error {
	message := fmt.Sprintf("%s is not a valid space. %s", space,
		styles.Suggestion("pm space list"))

	return errors.New(message)
}

// Add a space to the registered spaces.
func Add(space string) error {
	spaceList := viper.GetStringSlice("spaces.list")

	spaceList = append(spaceList, space)
	viper.Set("spaces.list", spaceList)

	return viper.WriteConfig()
}

// Remove a space from the registered spaces.
func Remove(space string) error {
	spaceList := viper.GetStringSlice("spaces.list")

	spaceList = slices.DeleteFunc(spaceList, func(_space string) bool {
		return _space == space
	})

	viper.Set("spaces.list", spaceList)
	return viper.WriteConfig()
}

// Return the full path to the space.
func GetPath(space string) string {
	HOME := viper.GetString("global.home")
	return path.Join(HOME, space)
}

func SetDefaultSpace(space string) error {
	viper.Set("spaces.default", space)
	return viper.WriteConfig()
}
