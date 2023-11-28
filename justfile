install:
    @go install && asdf reshim golang

run *ARGS:
    @go run main.go {{ARGS}}
