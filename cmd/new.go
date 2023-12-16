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
	templatesLib "github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// newCmd represents the new command
var newCmd = &cobra.Command{
	Use:     "new [template] <project>",
	Short:   "Create a new empty project",
	GroupID: "project",
	Example: `  pm new portfolio
  pm new cargo portfolio -s personal`,
	Args: cobra.RangeArgs(1, 2),
	ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		if len(args) >= 1 {
			return nil, cobra.ShellCompDirectiveNoFileComp
		}

		templates := viper.GetStringMapStringSlice("templates")
		templateNames := []string{}

		for name := range templates {
			templateNames = append(templateNames, name)
		}

		return templateNames, cobra.ShellCompDirectiveNoFileComp
	},

	RunE: func(cmd *cobra.Command, args []string) error {
		var templateName, projectName string

		if len(args) == 1 {
			projectName = args[0]
			templateName = "default"
		} else {
			projectName = args[1]
			templateName = args[0]
		}

		space, _ := cmd.Flags().GetString("space")
		verbose, _ := cmd.Flags().GetBool("verbose")

		if projects.IsInShortFormat(projectName) {
			if len(space) > 0 {
				return errors.New("cannot use short format with the --space flag")
			}

			space, projectName = projects.ParseShortFormat(projectName)
		} else {
			if len(space) == 0 {
				space = viper.GetString("spaces.default")
			}
		}

		if !spaces.IsValid(space) {
			message := fmt.Sprintf("%s is not a valid space. See %s", space,
				styles.YellowUnderline.Render("pm space list"))

			return errors.New(message)
		}

		if projects.Exists(space, projectName) {
			return errors.New(fmt.Sprintf("project %s already exists in space %s", projectName, space))
		}

		commands, ok := templatesLib.FindTemplate(templateName)

		if !ok {
			message := fmt.Sprintf("%s is not a valid template. See %s", templateName,
				styles.YellowUnderline.Render("pm template list"))

			return errors.New(message)
		}

		if err := projects.Create(space, projectName, commands, verbose); err != nil {
			return err
		}

		styles.Success(fmt.Sprintf("created project %s in space %s", projectName, space))
		return nil
	},
}

func init() {
	RootCmd.AddCommand(newCmd)
	newCmd.Flags().StringP("space", "s", "", "space to create the project in")

	newCmd.RegisterFlagCompletionFunc("space", func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		return viper.GetStringSlice("spaces.list"), cobra.ShellCompDirectiveNoFileComp
	})

	newCmd.Flags().BoolP("verbose", "v", false, "show template execution output")
}
