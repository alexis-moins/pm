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

	scriptsLib "github.com/alexis-moins/pm/internal/scripts"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/cobra"
)

// showCmd represents the show command
var showCmd = &cobra.Command{
	Use:   "show <script>",
	Short: "Show a script",

	RunE: func(cmd *cobra.Command, args []string) error {
		scripts, err := scriptsLib.ListScripts()

		if err != nil {
			return err
		}

		scriptName := args[0]
		script, ok := scripts[scriptName]

		if !ok {
			message := fmt.Sprintf("script %s not found. See %s", scriptName,
				styles.YellowUnderline.Render("pm script list"))

			return errors.New(message)
		}

		for _, command := range script.Exec {
			fmt.Printf("%s %s\n", styles.Red.Render("*"), command)
		}

		return nil
	},
}

func init() {
	scriptCmd.AddCommand(showCmd)
}
