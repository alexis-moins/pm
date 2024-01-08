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

	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
)

// defaultCmd represents the default command
var defaultCmd = &cobra.Command{
	Use:     "default <space>",
	Short:   "Set the default space",
	Args:    cobra.ExactArgs(1),
	Example: "  pm space default personal",

	RunE: func(cmd *cobra.Command, args []string) error {
		space := args[0]

		if !spaces.IsRegistered(space) {
			message := fmt.Sprintf("%s is not a valid space. %s", space,
				styles.Suggestion("pm space list"))

			return errors.New(message)
		}

		err := spaces.SetDefaultSpace(space)

		if err != nil {
			return errors.New("unable to set default space")
		}

		message := fmt.Sprintf("set default space to %s", space)
		styles.Success(message)

		return nil
	},
}

func init() {
	spaceCmd.AddCommand(defaultCmd)
}
