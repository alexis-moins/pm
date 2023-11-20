package tmux

import (
	"fmt"
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

func Attach(session string) error {
	if insideTmux() {
		return Exec("switch-client", "-t", session).Run()
	}

	return Exec("attach", "-t", session).Run()
}

func CreateSession(name string, path string) error {
	if insideTmux() {
		err := Exec("new-session", "-c", path, "-s", name, "-d").Run()

		if err != nil {
			return err
		}

		return Exec("switch-client", "-t", name).Run()
	}

	out, err := Exec("new-session", "-c", path, "-s", name).CombinedOutput()

	fmt.Printf("out: %v\n", string(out))
	return err
}
