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
	"github.com/alexis-moins/pm/internal/styles"
	"github.com/spf13/viper"
)

const PATH_TOKEN = "{path}"
const SPACE_TOKEN = "{space}"
const PROJECT_TOKEN = "{project}"

type Template = []Step

// Run goes over each steps of the template and execute them.
func Run(template Template, space, project, path string) error {
	for index, step := range template {
		output, err := step.run(space, project, path)

		if err != nil {
			output = fmt.Sprintf("unable to run step %d\n%s", index+1,
				styles.Get("comment").Render(output))

			return errors.New(output)
		}

		if len(output) > 0 {
			fmt.Println(styles.Get("comment").Render(output))
		}
	}

	return nil
}

// withSteps ensure the given template is valid.
func withSteps(template Template) (Template, error) {
	for index, step := range template {
		if len(step.Command) == 0 {
			return Template{}, errors.New(fmt.Sprintf("unable to parse step %d: step must contain the 'command' key", index+1))
		}
	}

	return template, nil
}

// Step represents a command to execute in a specific directory.
type Step struct {
	Command []string `json:"command"`
	Dir     string   `json:"dir"`
}

func (self Step) run(space, project, path string) (string, error) {
	command := self.getCommand(space, project, path)

	fmt.Printf("%s %s\n", styles.Get("success").Render("*"),
		strings.Join(command.Args, " "))

	output, err := command.CombinedOutput()
	return string(output), err
}

func (self Step) subsitute(space, project, path string) []string {
	command := []string{}

	for _, argument := range self.Command {
		argument = strings.ReplaceAll(argument, SPACE_TOKEN, space)
		argument = strings.ReplaceAll(argument, PROJECT_TOKEN, project)
		argument = strings.ReplaceAll(argument, PATH_TOKEN, path)

		command = append(command, argument)
	}

	return command
}

func (self Step) getCommand(space, project, path string) *exec.Cmd {
	command := self.subsitute(space, project, path)
	cmd := exec.Command(command[0], command[1:]...)

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

// Default returns the default template to add when there is not configuration
// file yet.
func Default() Template {
	return Template{
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
	viper.UnmarshalKey("templates", &templates)

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

func Add(name string, steps []Step) error {
	templates := ListTemplates()

	templates[name] = steps
	viper.Set("templates", templates)

	if err := viper.WriteConfig(); err != nil {
		return err
	}

	return nil
}

func Remove(name string) error {
	templates := ListTemplates()

	delete(templates, name)
	viper.Set("templates", templates)

	if err := viper.WriteConfig(); err != nil {
		return err
	}

	return nil
}

func FromFile(file *os.File) (Template, error) {
	data, err := io.ReadAll(file)

	if err != nil {
		return nil, err
	}

	return fromByteSlice(data)
}

func fromByteSlice(template []byte) (Template, error) {
	steps := []Step{}
	err := json.Unmarshal(template, &steps)

	if err != nil {
		return nil, err
	}

	return withSteps(steps)
}

func FromConfig(key string) (Template, error) {
	template := []Step{}
	viper.UnmarshalKey(key, &template)

	return withSteps(template)
}
