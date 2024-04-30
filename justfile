SCRIPT := "pm"

generate:
    @bashly generate --upgrade

watch:
    @bashly generate --watch

build:
    @bashly generate --env=production --upgrade

run *ARGS:
    @./{{SCRIPT}} {{ARGS}}
