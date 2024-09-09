build:
	@bashly generate --env=production --upgrade

watch:
	@bashly generate --watch

re:
	@bash uninstall.sh && bash install.sh
