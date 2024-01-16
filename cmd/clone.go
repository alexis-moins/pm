/*
Copyright © 2023 Alexis Moins <sinus.nacre0v@icloud.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package cmd

import (
	"errors"
	"fmt"
	"path"
	"regexp"
	"strings"

	_projects "github.com/alexis-moins/pm/internal/projects"
	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var repositoryRegex = regexp.MustCompile(`^(?:git@)?([\w\.]+:)?([^/]+/[^/\.]+)(?:\.git)?$`)

// cloneCmd represents the clone command
var cloneCmd = &cobra.Command{
	Use:     "clone <repository>",
	Short:   "Clone a remote git repository",
	Args:    cobra.ExactArgs(1),
	GroupID: "project",
	Example: `  pm clone alexis-moins/recipe
  pm clone git@github.com:neovim/neovim.git -n nvim -s tools`,

	RunE: func(cmd *cobra.Command, args []string) error {
		repository := args[0]

		space, _ := cmd.Flags().GetString("space")
		nameFlag, _ := cmd.Flags().GetString("name")

		hostname := viper.GetString("commands.clone.hostname")

		if host, _ := cmd.Flags().GetString("hostname"); len(host) > 0 {
			hostname = host
		}

		if len(space) == 0 {
			space = viper.GetString("spaces.default")
		}

		repository = repositoryRegex.ReplaceAllString(repository, "${1}${2}")
		parts := strings.Split(repository, ":")

		// If split succeeds, the first part is the hostname
		if len(parts) == 2 {
			hostname = parts[0]
		}

		// Last part must be username/project
		repository = parts[len(parts)-1]

		if !spaces.IsValid(space) {
			message := fmt.Sprintf("%s is not a valid space. %s", space,
				styles.Suggestion("pm space list"))

			return errors.New(message)
		}

		var projectName string

		if len(nameFlag) > 0 {
			projectName = nameFlag
		} else {
			projectName = path.Base(repository)
		}

		if _projects.Exists(space, projectName) {
			return errors.New(fmt.Sprintf("project %s already exists in space %s", projectName, space))
		}

		if err := _projects.Clone(hostname, repository, space, projectName); err != nil {
			return err
		}

		message := fmt.Sprintf("cloned project %s in space %s", projectName, space)
		styles.Success(message)

		return nil
	},
}

func init() {
	RootCmd.AddCommand(cloneCmd)

	cloneCmd.Flags().StringP("space", "s", "", "space to clone in")
	cloneCmd.Flags().StringP("name", "n", "", "name of the project")

	cloneCmd.Flags().StringP("hostname", "H", "", "default git hostname")
	// viper.BindPFlag("commands.clone.hostname", cloneCmd.Flags().Lookup("hostname"))

	cloneCmd.RegisterFlagCompletionFunc("space", spaces.SpaceFlagCompletionFunc)
}
