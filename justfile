generate ENV='production':
    @bashly generate --env={{ENV}}

watch ENV='production':
    @bashly generate --env={{ENV}} --watch
