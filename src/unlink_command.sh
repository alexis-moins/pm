local path="${args[path]}"

if [[ -f "${path}/pm" ]]; then
    run_silent rm "${path}/pm"

    info "link removed from ${path}."
else
    error "no link found in ${path}."
    exit 1
fi
