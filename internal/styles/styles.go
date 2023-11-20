package styles

import (
	"fmt"

	"github.com/charmbracelet/lipgloss"
)

var Red = lipgloss.NewStyle().Foreground(lipgloss.Color("1"))

func Magenta(message string) lipgloss.Style {
	return lipgloss.NewStyle().Foreground(lipgloss.Color("5")).SetString(message)
}

func YellowUnderline(message string) lipgloss.Style {
    return lipgloss.NewStyle().Foreground(lipgloss.Color("#eed49f")).Underline(true).SetString(message)
}

func Error(error string) {
	fmt.Printf("%s %s\n", Red.Render("pm:"), error)
}

func Suggestion(message string) {
	fmt.Printf("See %s\n", YellowUnderline(message))
}
