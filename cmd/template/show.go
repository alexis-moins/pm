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
	"strings"

	"github.com/alexis-moins/pm/internal/styles"
	templatesLib "github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
)

// showCmd represents the show command
var showCmd = &cobra.Command{
	Use:   "show <template>",
	Short: "Show a template",
	Args:  cobra.ExactArgs(1),

	ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		if len(args) == 0 {
			templateNames := []string{}

			for name := range templatesLib.ListTemplates() {
				templateNames = append(templateNames, name)
			}

			return templateNames, cobra.ShellCompDirectiveNoFileComp
		}

		return nil, cobra.ShellCompDirectiveNoFileComp
	},

	RunE: func(cmd *cobra.Command, args []string) error {
		templateName := args[0]
		template, ok := templatesLib.FindTemplate(templateName)

		if !ok {
			message := fmt.Sprintf("template %s not found. %s", templateName,
				styles.Suggestion("pm template list"))

			return errors.New(message)
		}

		for _, step := range template {
			fmt.Printf("%s %s\n", styles.Get("error").Render("*"), strings.Join(step.Command, " "))
		}

		return nil
	},
}

func init() {
	templateCmd.AddCommand(showCmd)
}
