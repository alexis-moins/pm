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

	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var space string

// openCmd represents the open command
var openCmd = &cobra.Command{
	Use:     "open [NAME]",
	Short:   "Open a project in a tmux session",
	GroupID: "project",

	Args: cobra.MaximumNArgs(1),
	Example: `  pm open recipe
  pm open neovim --space tools`,

	Run: func(cmd *cobra.Command, args []string) {
		// TODO: Filter projects if args is empty

		if len(space) == 0 {
			// Use default space if no space is provided
			space = viper.GetString("default")
		}

		fmt.Printf("space: %v\n", space)

		if !spaces.SpaceIsValid(space) {

			os.Exit(1)
		}
	},
}

func init() {
	rootCmd.AddCommand(openCmd)

	openCmd.Flags().StringVarP(&space, "space", "s", "", "space where the project is")
}
