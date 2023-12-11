package tmux

import (
	"errors"
	"os"
	"os/exec"
	"strings"
)

var tmuxSocket = os.Getenv("TMUX")

func insideTmux() bool {
	return len(tmuxSocket) > 0
}

func IsRunning() bool {
    _, err := Exec("info")
    return err == nil
}

func Exec(arg ...string) (string, error) {
	cmd := exec.Command("tmux", arg...)

	// Required for tmux to run in tty
	cmd.Stdin = os.Stdin

	output, err := cmd.CombinedOutput()

	return string(output), err
}

func Attach(session string) (string, error) {
	if insideTmux() {
		return Exec("switch-client", "-t", session)
	}

	return Exec("attach", "-t", session)
}

func CreateSession(name string, path string) (string, error) {
	if insideTmux() {
		output, err := Exec("new-session", "-c", path, "-s", name, "-d")

		if err != nil {
			return output, err
		}

		return Exec("switch-client", "-t", name)
	}

	return Exec("new-session", "-c", path, "-s", name)
}

// ListWindows return the list of the windows present in the current tmux
// server. Each windows has the format 'sessionName: panePath'.
func ListWindows() ([]string, error) {
	output, err := Exec("list-windows", "-aF", "#S: #{pane_current_path}")

	if err != nil {
		return []string{}, errors.New(output)
	}

	return strings.Split(string(output), "\n"), nil
}
