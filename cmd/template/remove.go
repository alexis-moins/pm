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
package template

import (
	"errors"
	"fmt"

	"github.com/alexis-moins/pm/internal/styles"
	"github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
)

// removeCmd represents the remove command
var removeCmd = &cobra.Command{
	Use:     "remove <template>",
	Short:   "Remove a template",
	Aliases: []string{"delete", "rm"},
	Args:    cobra.ExactArgs(1),

	ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		if len(args) == 0 {
			templateList := templates.ListTemplates()
			return templates.GetTemplateNames(templateList), cobra.ShellCompDirectiveNoFileComp
		}

		return nil, cobra.ShellCompDirectiveNoFileComp
	},

	RunE: func(cmd *cobra.Command, args []string) error {
		templateName := args[0]

		if _, ok := templates.FindTemplate(templateName); !ok {
			message := fmt.Sprintf("template %s not found. See %s", templateName,
				styles.YellowUnderline.Render("pm template list"))

			return errors.New(message)
		}

		if err := templates.RemoveTemplate(templateName); err != nil {
			return errors.New("unable to remove template")
		}

		styles.Success("removed template " + templateName)
		return nil
	},
}

func init() {
	templateCmd.AddCommand(removeCmd)
}
