local template="${args[template]}"

if [[ -z "${template}" ]]; then
    # interactively select a template if none is provided
    template="$(filter_templates)"

    [[ -z "${template}" ]] && exit 0
fi

echo "${template}" > "${TEMPLATE_INDEX}"
success "using '${template}' as global template"
