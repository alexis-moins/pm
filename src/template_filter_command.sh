local only="${args[--only]}"

local templates="$(list_templates_by_group "${only}")"

if [[ -n "${templates}" ]]; then
    pipe "${templates}" | command "${deps[gum]}" filter --placeholder "Filter templates"
fi
