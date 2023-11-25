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
	"fmt"

	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// addCmd represents the add command
var listCmd = &cobra.Command{
	Use:     "list",
	Short:   "List registered spaces",
	Aliases: []string{"ls"},
	Example: "  pm space list",

	Run: func(cmd *cobra.Command, args []string) {
		spaceList := viper.GetStringSlice("spaces")
		defaultSpace := viper.GetString("default")

		for _, space := range spaceList {
			if space == defaultSpace {
				fmt.Printf("%s %s\n", styles.Green.Render("D"), space)
			} else {
				fmt.Printf("  %s\n", space)
			}
		}
	},
}

func init() {
	spaceCmd.AddCommand(listCmd)
}
