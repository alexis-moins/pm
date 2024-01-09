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
	"os"
	"path"

	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/alexis-moins/pm/internal/templates"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:          "pm",
	Short:        "Project manager built on top of tmux",
	Version:      "0.7.0",
	SilenceUsage: true,

	PersistentPreRunE: func(cmd *cobra.Command, args []string) error {
		defaultSpace := viper.GetString("spaces.default")

		if err := os.MkdirAll(spaces.GetPath(defaultSpace), 0750); err != nil {
			return err
		}

		return nil
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the RootCmd.
func Execute() {
	err := RootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	home, err := os.UserHomeDir()

	if err != nil {
		styles.Fatal("unable to retrieve home directory")
		os.Exit(1)
	}

	viper.SetDefault("global.home", path.Join(home, "dev"))

	viper.SetConfigName("config")
	viper.SetConfigType("json")

	configPath := path.Join(home, ".config/pm")

	viper.AddConfigPath(configPath)

	viper.SetDefault("spaces.default", "default")
	viper.SetDefault("spaces.list", []string{"default"})

	defaultColors := map[string]string{
		"comment":    "#6e738d",
		"error":      "#ed8796",
		"success":    "#a6da95",
		"suggestion": "#eed49f",
	}

	viper.SetDefault("global.colors", defaultColors)
	viper.SetDefault("templates.default", templates.DefaultTemplate())

	if err := viper.ReadInConfig(); err != nil {
		if err := os.MkdirAll(configPath, 0750); err != nil {
			panic(err)
		}

		viper.SafeWriteConfig()
	}

	projectGroup := cobra.Group{
		ID:    "project",
		Title: "Project Commands:",
	}

	RootCmd.AddGroup(&projectGroup)
	RootCmd.SetErrPrefix(styles.Get("error").Render("pm:"))
}
