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
	"os"
	"path/filepath"

	"github.com/alexis-moins/pm/internal/styles"
	"github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
)

// addCmd represents the add command
var addCmd = &cobra.Command{
	Use:     "add <name> <path>",
	Short:   "Add a template",
	Args:    cobra.ExactArgs(2),
	Example: `  pm template add golang template.json`,

	ValidArgsFunction: func(cmd *cobra.Command, args []string, toComplete string) ([]string, cobra.ShellCompDirective) {
		if len(args) == 0 {
			return nil, cobra.ShellCompDirectiveNoFileComp
		}

		if len(args) == 1 {
			return nil, cobra.ShellCompDirectiveDefault
		}

		return nil, cobra.ShellCompDirectiveNoFileComp
	},

	RunE: func(cmd *cobra.Command, args []string) error {
		templateName, filePath := args[0], args[1]

		force, _ := cmd.Flags().GetBool("force")
		_, ok := templates.FindTemplate(templateName)

		if ok && !force {
			message := fmt.Sprintf("template %s already exists. %s",
				templateName, styles.Suggestion("pm template list"))

			return errors.New(message)
		}

		path, err := filepath.Abs(filePath)

		if err != nil {
			return err
		}

		file, err := os.Open(path)

		if err != nil {
			return err
			// return errors.New(fmt.Sprintf("%s: no such file", path))
		}

		defer file.Close()

		if info, err := file.Stat(); err != nil || info.IsDir() {
			return errors.New(fmt.Sprintf("%s: unable to open file", path))
		}

		template, err := templates.ParseTemplate(file)

		if err != nil {
			return err
		}

		if err = templates.AddTemplate(templateName, template); err != nil {
			return errors.New("unable to save template")
		}

		styles.Success("Added template " + templateName)
		return nil
	},
}

func init() {
	templateCmd.AddCommand(addCmd)

	addCmd.Flags().BoolP("force", "f", false, "overwrite existing template")
}
