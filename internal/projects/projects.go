package projects

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"path"
	"strings"

	"github.com/spf13/viper"
)

// Return true if the given project exists on the
// given space (corresponds to an existing directory).
func Exists(name, space string) bool {
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
func GetPath(name, space string) string {
	HOME := viper.GetString("HOME")
	return path.Join(HOME, space, name)
}

// Return the list of projects in all registered spaces.
func ListProjects() error {
	cmd := exec.Command("gum", "filter", "--placeholder", "Select a project...", "--fuzzy")

	spaces := strings.Join(viper.GetStringSlice("spaces"), " ")
	cmd.Stdin = bytes.NewReader([]byte(spaces))

	output, err := cmd.CombinedOutput()

	fmt.Printf("output: %v\n", output)
	return err
}
