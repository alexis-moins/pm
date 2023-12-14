package scripts

import "github.com/spf13/viper"

type Script struct {
	Exec []string `json:"exec"`
	Init bool     `json:"init"`
}

// New returns a new Script
func New(exec []string, init bool) Script {
	return Script{exec, init}
}

func ListScripts() (map[string]Script, error) {
	rawScripts := viper.GetStringMap("scripts")

	scripts := map[string]Script{}

	for name := range rawScripts {
		script := Script{}
		err := viper.UnmarshalKey("scripts."+name, &script)

		if err != nil {
			return nil, err
		}

		scripts[name] = script
	}

	return scripts, nil
}
