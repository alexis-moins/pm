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
	"github.com/spf13/viper"
)

// addCmd represents the add command
var removeCmd = &cobra.Command{
	Use:     "remove",
	Short:   "Remove a registered spaces",
	Args:    cobra.ExactArgs(1),
	Aliases: []string{"rm"},
	Example: "  pm space remove personal",
	ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		if len(args) > 0 {
			return []string{}, cobra.ShellCompDirectiveNoFileComp
		}
		return viper.GetStringSlice("spaces.list"), cobra.ShellCompDirectiveNoFileComp
	},

	RunE: func(cmd *cobra.Command, args []string) error {
		space := args[0]

		if !spaces.IsRegistered(space) {
			message := fmt.Sprintf("%s is not a valid space. %s", space,
				styles.Suggestion("pm space list"))

			return errors.New(message)
		}

		err := spaces.Remove(space)

		if err != nil {
			return err
		}

		message := fmt.Sprintf("removed space %s", space)
		styles.Success(message)

		return nil
	},
}

func init() {
	spaceCmd.AddCommand(removeCmd)

	removeCmd.RegisterFlagCompletionFunc("space", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		return viper.GetStringSlice("spaces.list"), cobra.ShellCompDirectiveNoFileComp
	})
}
