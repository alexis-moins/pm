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
	"fmt"
	"strings"

	_templates "github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// addCmd represents the add command
var addCmd = &cobra.Command{
	Use:     "add <name> [template]",
	Short:   "Add a new template",
	Args:    cobra.MinimumNArgs(1),
	Example: `  pm template add cargo-new "cargo new PATH"`,

	RunE: func(cmd *cobra.Command, args []string) error {
		fmt.Println("add called")

        templates, err := _templates.ListTemplates()

        if err != nil {
            return err
        }

        fmt.Printf("templates: %v\n", templates)

        newTemplate := _templates.Template{
            Commands: []string{strings.Join(args[1:], " ")},
            FromInside: false,
        }

        templates[args[0]] = newTemplate

        viper.Set("templates", templates)
        viper.WriteConfig()

		return nil
	},
}

func init() {
	templateCmd.AddCommand(addCmd)

    addCmd.Flags().BoolP("from-inside", "f", false, "the template must be run inside the project")
}
