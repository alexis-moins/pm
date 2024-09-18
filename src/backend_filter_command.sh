local only="${args[--only]}"

local backends="$(list_backends_by_group "${only}")"

if [[ -n "${backends}" ]]; then
    pipe "${backends}" | command "${deps[gum]}" filter --placeholder "Filter backends"
fi
