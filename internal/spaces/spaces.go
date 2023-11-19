package spaces

import (
	"slices"

	"github.com/spf13/viper"
)

func SpaceIsRegistered(space string) bool {
	if space == viper.GetString("default") {
		return true
	}

	spaces := viper.GetStringSlice("spaces")
	return slices.Contains(spaces, space)
}

// Return true if the given space is registered and
// corresponds to an existing directory.
func SpaceIsValid(space string) bool {
	return SpaceIsRegistered(space)
}
