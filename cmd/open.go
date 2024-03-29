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

	"github.com/alexis-moins/pm/internal/projects"
	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// openCmd represents the open command
var openCmd = &cobra.Command{
	Use:     "open <project>",
	Short:   "Open a project in a tmux session",
	GroupID: "project",
	Example: `  pm open recipe
  pm open tools/neovim
  pm open neovim --space tools`,
	Args: cobra.ExactArgs(1),

	ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		if len(args) > 0 {
			return []string{}, cobra.ShellCompDirectiveNoFileComp
		}

		if space, _ := cmd.Flags().GetString("space"); len(space) > 0 {
			return projects.ListProjectsInSpace(space, false), cobra.ShellCompDirectiveNoFileComp
		}

		return projects.ListProjects(), cobra.ShellCompDirectiveNoFileComp
	},

	RunE: func(cmd *cobra.Command, args []string) error {
		projectName := args[0]
		space, _ := cmd.Flags().GetString("space")

		if projects.IsInShortFormat(projectName) {
			if len(space) > 0 {
				return errors.New("cannot use short format with the --space flag")
			}

			space, projectName = projects.ParseShortFormat(projectName)
		} else if len(space) == 0 {
			space = viper.GetString("spaces.default")
		}

		if !spaces.IsValid(space) {
			return spaces.InvalidSpaceError(space)
		}

		if !projects.Exists(space, projectName) {
			message := fmt.Sprintf("project %s not found in space %s. %s", projectName, space,
				styles.Suggestion("pm space list"))

			return errors.New(message)
		}

		return projects.Open(space, projectName)
	},
}

func init() {
	RootCmd.AddCommand(openCmd)

	openCmd.Flags().StringP("space", "s", "", "space to search in")
	openCmd.RegisterFlagCompletionFunc("space", spaces.SpaceFlagCompletionFunc)
}
