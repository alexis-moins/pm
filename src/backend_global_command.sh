local backend="${args[backend]}"

if [[ -z "${backend}" ]]; then
    # Interactively select a backend if none is provided
    backend="$(filter_backends)"

    [[ -z "${backend}" ]] && exit 0
fi

echo "${backend}" > "${BACKEND_INDEX}"
success "using '${backend}' as global backend"
