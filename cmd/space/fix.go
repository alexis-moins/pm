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
	"slices"

	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// fixCmd represents the fix command
var fixCmd = &cobra.Command{
	Use:   "fix",
	Short: "Fix registered spaces",

	RunE: func(cmd *cobra.Command, args []string) error {
		spaceList := viper.GetStringSlice("spaces")
		force, _ := cmd.Flags().GetBool("force")

		removedSpaces := []string{}

		for _, space := range spaceList {
			if !spaces.Exists(space) {
				removedSpaces = append(removedSpaces, space)
			}
		}

		if len(removedSpaces) == 0 {
			styles.Success("No spaces to fix")
			return nil
		}

		message := fmt.Sprintf("This operation would remove %d space(s)", len(removedSpaces))
		fmt.Println(message)

		for _, space := range removedSpaces {
			fmt.Printf("%s %s\n", styles.Red.Render("*"), space)

			if force {
				spaceList = slices.DeleteFunc(spaceList, func(s string) bool {
					return s == space
				})
			}
		}

		if force && len(removedSpaces) > 0 {
			viper.Set("spaces", spaceList)
			println("hello")

			if err := viper.WriteConfig(); err != nil {
				return err
			}
		}

		return nil
	},
}

func init() {
	spaceCmd.AddCommand(fixCmd)

	fixCmd.Flags().BoolP("force", "f", false, "force fixes to happen")
}
