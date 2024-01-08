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
	"slices"
	"strings"

	_projects "github.com/alexis-moins/pm/internal/projects"
	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// listCmd represents the list command
var listCmd = &cobra.Command{
	Use:     "list",
	Short:   "List projects",
	GroupID: "project",
	Aliases: []string{"ls"},
	Example: `  pm list
  pm list -s personal -f recipe`,

	RunE: func(cmd *cobra.Command, args []string) error {
		space, _ := cmd.Flags().GetString("space")
		filter, _ := cmd.Flags().GetString("filter")

		var projects []string

		if len(space) > 0 {
			if !spaces.IsValid(space) {
				message := fmt.Sprintf("%s is not a valid space. See %s", space,
					styles.Suggestion("pm space list"))

				return errors.New(message)
			}

			projects = _projects.ListProjectsInSpace(space, true)
		} else {
			projects = _projects.ListProjects()
		}

		if len(filter) > 0 {
			projects = slices.DeleteFunc(projects, func(project string) bool {
				return !strings.Contains(project, filter)
			})
		}

		fmt.Println(strings.Join(projects, "\n"))
		return nil
	},
}

func init() {
	RootCmd.AddCommand(listCmd)

	listCmd.Flags().StringP("filter", "f", "", "Filter output by project name")
	listCmd.Flags().StringP("space", "s", "", "space to list pojects in")

	listCmd.RegisterFlagCompletionFunc("space", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		return viper.GetStringSlice("spaces.list"), cobra.ShellCompDirectiveNoFileComp
	})
}
