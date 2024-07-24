watch:
	@bashly generate --watch

build:
	@bashly generate --env=production --upgrade
