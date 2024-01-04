package templates

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"os"
	"os/exec"
	"strings"

	"github.com/alexis-moins/pm/internal/spaces"
	"github.com/spf13/viper"
)

const PATH_TOKEN = "{path}"
const SPACE_TOKEN = "{space}"
const PROJECT_TOKEN = "{project}"

type Step struct {
	Command []string `json:"command"`
	Dir     string   `json:"dir"`
}

func (self *Step) Subsitute(space, project, path string) {
	for index, argument := range self.Command {
		argument = strings.ReplaceAll(argument, SPACE_TOKEN, space)
		argument = strings.ReplaceAll(argument, PROJECT_TOKEN, project)
		argument = strings.ReplaceAll(argument, PATH_TOKEN, path)

		self.Command[index] = argument
	}
}

func (self Step) GetCommand(space, path string) *exec.Cmd {
	cmd := exec.Command(self.Command[0], self.Command[1:]...)

	switch self.Dir {
	case "SPACE":
		cmd.Dir = spaces.GetPath(space)
		break

	case "PROJECT":
		cmd.Dir = path
		break
	}

	return cmd
}

func DefaultTemplate() []Step {
	return []Step{
		{
			Command: []string{"mkdir", "{path}"},
		},
		{
			Command: []string{"git", "init"},
			Dir:     "PROJECT",
		},
	}
}

func GetTemplateNames(templates map[string][]Step) []string {
	templateNames := []string{}

	for name := range templates {
		templateNames = append(templateNames, name)
	}

	return templateNames
}

func ListTemplates() map[string][]Step {
	templates := map[string][]Step{}
	viper.UnmarshalKey(fmt.Sprintf("templates"), &templates)

	return templates
}

// FindTemplate returns the steps associated with a template
// name, if any was found.
func FindTemplate(name string) ([]Step, bool) {
	template, ok := ListTemplates()[name]

	if !ok {
		return nil, false
	}

	return template, true
}

func AddTemplate(name string, steps []Step) error {
	templates := ListTemplates()

	templates[name] = steps
	viper.Set("templates", templates)

	if err := viper.WriteConfig(); err != nil {
		return err
	}

	return nil
}

func RemoveTemplate(name string) error {
	templates := ListTemplates()

	delete(templates, name)
	viper.Set("templates", templates)

	if err := viper.WriteConfig(); err != nil {
		return err
	}

	return nil
}

func ParseTemplate(file *os.File) ([]Step, error) {
	data, err := io.ReadAll(file)

	if err != nil {
		return nil, err
	}

	steps := []Step{}
	err = json.Unmarshal(data, &steps)

	if err != nil {
		return nil, err
	}

	for index, step := range steps {
		if len(step.Command) == 0 {
			return nil, errors.New(fmt.Sprintf("unable to parse step %d: step must contain the 'command' key", index+1))
		}
	}

	return steps, nil
}
