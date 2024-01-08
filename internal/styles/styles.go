package styles

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/spf13/viper"
)

func Get(key string) lipgloss.Style {
	colors := viper.GetStringMapString("global.colors")

	colorCode, ok := colors[strings.ToLower(key)]
	if !ok {
		colorCode = "7"
	}

	color := lipgloss.Color(colorCode)
	return lipgloss.NewStyle().Foreground(lipgloss.Color(color))
}

var Underline = lipgloss.NewStyle().Underline(true)
var Yellow = lipgloss.NewStyle().Foreground(lipgloss.Color("3"))

func Fatal(error string) {
	fmt.Printf("%s %s\n", Get("error").Render("pm:"), error)
}

func Suggestion(message string) string {
	return fmt.Sprintf("See %s", Get("suggestion").Underline(true).Render(message))
}

func Success(message string) {
	fmt.Printf("%s %s\n", Get("success").Render("✔"), message)
}
