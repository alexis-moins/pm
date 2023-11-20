package tmux

import (
	"os"
	"os/exec"
)

var tmuxSocket = os.Getenv("TMUX")

func insideTmux() bool {
	return len(tmuxSocket) > 0
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
