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

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:     "pm",
	Short:   "Project manager built on top of tmux",
	Version: "0.0.1",

	PersistentPreRun: func(cmd *cobra.Command, args []string) {
		defaultSpace := viper.GetString("default")

		if err := os.MkdirAll(defaultSpace, 0750); err != nil {
			panic(err)
		}
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
	HOME := os.Getenv("HOME")

	viper.SetEnvPrefix("PM")
	viper.AutomaticEnv()

	viper.SetDefault("HOME", path.Join(HOME, "dev"))

	viper.SetConfigName("config")
	viper.SetConfigType("yaml")

	configPath := path.Join(HOME, ".config/pm")

	viper.AddConfigPath(configPath)

	viper.SetDefault("default", "default")
	viper.SetDefault("spaces", []string{})

	if err := viper.ReadInConfig(); err != nil {
		if err := os.MkdirAll(configPath, 0750); err != nil {
			panic(err)
		}

		viper.SafeWriteConfig()
	}

	projectGroup := cobra.Group{
		ID:    "project",
		Title: "PROJECT",
	}

	RootCmd.AddGroup(&projectGroup)
}
