SCRIPT := "pm"

generate:
    @bashly generate --upgrade --env=production

watch:
    @bashly generate --watch --env=production

build:
    @bashly generate --env=production --upgrade

run *ARGS:
    @./{{SCRIPT}} {{ARGS}}
