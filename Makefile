watch:
	@bashly generate --watch

build:
	@bashly generate --env=production --upgrade

re:
	@bash uninstall.sh && bash install.sh
