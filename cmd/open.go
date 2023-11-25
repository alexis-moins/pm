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
	"os"
	"strings"

	"github.com/alexis-moins/pm/internal/projects"
	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/alexis-moins/pm/internal/tmux"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// openCmd represents the open command
var openCmd = &cobra.Command{
	Use:     "open <project>",
	Short:   "Open a project in a tmux session",
	GroupID: "project",
	Args:    cobra.ExactArgs(1),
	Example: `  pm open recipe
  pm open neovim --space tools`,

	Run: func(cmd *cobra.Command, args []string) {
		projectName := args[0]
		space, _ := cmd.Flags().GetString("space")

		if len(space) == 0 {
			space = viper.GetString("default")
		}

		if !spaces.IsValid(space) {
			fmt.Printf("space %s is not valid. ", styles.Magenta.Render(space))
			styles.Suggestion("pm space list")
			os.Exit(1)
		}

		if !projects.Exists(space, projectName) {
			fmt.Printf("project %s not found in space %s. ",
				styles.Magenta.Render(projectName),
				styles.Magenta.Render(space))

			styles.Suggestion("pm list")
			os.Exit(1)
		}

		output, err := tmux.Exec("list-windows", "-aF", "#S: #{pane_current_path}")

		if err != nil {
			fmt.Printf("err: %v\n", err)
			os.Exit(1)
		}

		windows := strings.Split(string(output), "\n")
		projectPath := projects.GetPath(space, projectName)

		for _, window := range windows {
			if window == fmt.Sprintf("%s: %s", projectName, projectPath) {
				_, err := tmux.Attach(projectName)

				if err != nil {
					fmt.Printf("err: %v\n", err)
					os.Exit(1)
				}

				os.Exit(0)
			}
		}

		// No session was found
		tmux.CreateSession(projectName, projectPath)
	},
}

func init() {
	RootCmd.AddCommand(openCmd)

	openCmd.Flags().StringP("space", "s", "", "space to search in")
}
