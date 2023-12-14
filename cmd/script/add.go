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
package script

import (
	"errors"
	"fmt"
	"strings"

	scriptsLib "github.com/alexis-moins/pm/internal/scripts"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// addCmd represents the add command
var addCmd = &cobra.Command{
	Use:     "add <name> [command]",
	Short:   "Add a new script",
	Args:    cobra.MinimumNArgs(2),
	Example: `  pm script add cargo-new cargo new PATH`,

	RunE: func(cmd *cobra.Command, args []string) error {
		init, _ := cmd.Flags().GetBool("init")

		scriptName := args[0]
		commands := strings.Join(args[1:], " ")

		scripts, err := scriptsLib.ListScripts()

		if err != nil {
			return err
		}

		if _, ok := scripts[scriptName]; ok {
			message := fmt.Sprintf("script %s already exists. See %s",
				scriptName, styles.YellowUnderline.Render("pm script list"))

			return errors.New(message)
		}

		script := scriptsLib.New([]string{commands}, init)

		viper.Set("scripts."+scriptName, script)
		if err := viper.WriteConfig(); err != nil {
			return err
		}

		styles.Success("Added script " + scriptName)
		return nil
	},
}

func init() {
	scriptCmd.AddCommand(addCmd)

	addCmd.Flags().BoolP("init", "i", false, "the script creates the directory itself")
}
