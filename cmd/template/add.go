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
	templatesLib "github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
)

// addCmd represents the add command
var addCmd = &cobra.Command{
	Use:     "add <name>",
	Short:   "Add a new template",
	Args:    cobra.ExactArgs(1),
	Example: `  pm template add cargo -e "cargo new PATH"
  pm template add go -e "mkdir PATH" -e "go mod init github.com/alexis-moins/NAME"`,

	RunE: func(cmd *cobra.Command, args []string) error {
		templateName := args[0]
		commands, _ := cmd.Flags().GetStringSlice("exec")

		_, ok := templatesLib.FindTemplate(templateName)

		if ok {
			message := fmt.Sprintf("template %s already exists. See %s",
				templateName, styles.YellowUnderline.Render("pm template list"))

			return errors.New(message)
		}

		err := templatesLib.AddTemplate(templateName, commands)

		if err != nil {
			return errors.New("unable to save template")
		}

		styles.Success("Added template " + templateName)
		return nil
	},
}

func init() {
	templateCmd.AddCommand(addCmd)

	addCmd.Flags().StringSliceP("exec", "e", []string{}, "list of commands to execute")
	addCmd.MarkFlagRequired("exec")
}
