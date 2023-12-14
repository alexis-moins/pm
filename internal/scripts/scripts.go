package scripts

type Script struct {
	Exec []string `json:"exec"`
	Init bool     `json:"init"`
}

func New(exec []string, init bool) Script {
	return Script{exec, init}
}
