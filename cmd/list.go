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
	"fmt"

	_projects "github.com/alexis-moins/pm/internal/projects"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
)

// listCmd represents the list command
var listCmd = &cobra.Command{
	Use:   "list",
	Short: "List projects",
	Aliases: []string{"ls"},
	Example: `  pm list
  pm list --porcelain`,
	Run: func(cmd *cobra.Command, args []string) {
		spaces := _projects.ListAllProjects()

		porcelain, _ := cmd.Flags().GetBool("porcelain")

		for space, projects := range spaces {
			if !porcelain && len(projects) > 0 {
				header := styles.Yellow.Render(fmt.Sprintf("[%s]", space))
				fmt.Println(header)
			}

			for _, project := range projects {
				var format string

				if !porcelain {
					format = fmt.Sprintf("%s", project)
				} else {
					format = fmt.Sprintf("%s/%s", space, project)
				}

				fmt.Println(format)
			}
		}
	},
}

func init() {
	RootCmd.AddCommand(listCmd)

	listCmd.Flags().BoolP("porcelain", "p", false, "Give the output in a stable, easy-to-parse format")
}
