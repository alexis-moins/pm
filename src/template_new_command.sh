local template_name="${args[template]}"

if [[ ! -d "${HOME}/.config/pm/templates" ]]; then
    command mkdir -p "${HOME}/.config/pm/templates"
fi

local new_template_path="${HOME}/.config/pm/templates/${template_name}.sh"

command cat > ${new_template_path} << EOF
# Information about the project are passed as environment variables in the following way:
#
# SPACE        - name of the space the project must be created in.
#
# SPACE_PATH   - absolute path to the space directory. It corresponds to the
#                following pattern evaluated: \${HOME}/\${PM_HOME}/\$SPACE.
#
# PROJECT      - name of the project that must be created.
#
# PROJECT_PATH - absolute path to the project directory. It corresponds to the
#                following pattern evaluated: \${SPACE_PATH}/\${PROJECT}.
echo "Hi from '${template_name}' template"
EOF

command "${EDITOR:-vim}" ${new_template_path}
