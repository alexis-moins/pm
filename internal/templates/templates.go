package templates

import (
	"github.com/spf13/viper"
)

type Template struct {
	Commands   []string `mapstructure:"commands"`
	FromInside bool     `mapstructure:"fromInside"`
}

func ListTemplates() (map[string]Template, error) {
	rawTemplates := viper.GetStringMap("templates")

	templates := map[string]Template{}

	for key := range rawTemplates {
		template := Template{}

		if err := viper.UnmarshalKey("templates."+key, &template); err != nil {
			return nil, err
		}

		templates[key] = template
	}

	return templates, nil
}
