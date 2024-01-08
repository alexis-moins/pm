package styles

import (
	"fmt"

	"github.com/charmbracelet/lipgloss"
)

var Red = lipgloss.NewStyle().Foreground(lipgloss.Color("1"))
var Green = lipgloss.NewStyle().Foreground(lipgloss.Color("2"))
var Magenta = lipgloss.NewStyle().Foreground(lipgloss.Color("5"))
var Underline = lipgloss.NewStyle().Underline(true)
var Yellow = lipgloss.NewStyle().Foreground(lipgloss.Color("3"))
var YellowUnderline = lipgloss.NewStyle().Foreground(lipgloss.Color("3")).Underline(true)
var Grey = lipgloss.NewStyle().Foreground(lipgloss.Color("#6e738d"))

func Error(error string) {
	fmt.Printf("%s %s\n", Red.Render("pm:"), error)
}

func Suggestion(message string) {
	fmt.Printf("see %s.\n", YellowUnderline.Render(message))
}

func Success(message string) {
	fmt.Printf("%s %s\n", Green.Render("✔"), message)
}
