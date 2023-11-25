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
package space

import (
	"errors"
	"fmt"
	"os"

	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
)

// addCmd represents the add command
var addCmd = &cobra.Command{
	Use:   "add <space>",
	Short: "Add a new space",
	Args:  cobra.ExactArgs(1),
	Example: `  pm space add personal
  pm space add tools -c`,

	RunE: func(cmd *cobra.Command, args []string) error {
		space := args[0]

		create, _ := cmd.Flags().GetBool("create")

		if !spaces.Exists(space) {
			if create {
				if err := os.MkdirAll(spaces.GetPath(space), 0750); err != nil {
					return err
				}
			} else {
				message := fmt.Sprintf("directory not found. Did you forget the %s flag?",
					styles.YellowUnderline.Render("--create"))

				return errors.New(message)
			}
		}

		if spaces.IsRegistered(space) {
			message := fmt.Sprintf("space %s has already been added", space)
			return errors.New(message)
		}

		err := spaces.Add(space)

		if err != nil {
			return err
		}

		message := fmt.Sprintf("added space %s", space)
		styles.Success(message)

		return nil
	},
}

func init() {
	spaceCmd.AddCommand(addCmd)

	addCmd.Flags().BoolP("create", "c", false, "Create the space if it does not exist")
}
