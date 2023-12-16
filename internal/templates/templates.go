package templates

import (
	"fmt"

	"github.com/spf13/viper"
)

// FindTemplate returns the commands associated with a template
// name, if any was found.
func FindTemplate(name string) ([]string, bool) {
	templates := viper.GetStringMapStringSlice("templates")

	template, ok := templates[name]

	if !ok {
		return nil, false
	}

	return template, true
}

func AddTemplate(name string, commands []string) error {
	name = fmt.Sprintf("templates.%s", name)
	viper.Set(name, commands)

	if err := viper.WriteConfig(); err != nil {
		return err
	}

	return nil
}

func RemoveTemplate(name string) error {
	templates := viper.GetStringMapStringSlice("templates")

	delete(templates, name)
	viper.Set("templates", templates)

	if err := viper.WriteConfig(); err != nil {
		return err
	}

	return nil
}
