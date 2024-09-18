local backend_name="${args[backend]}"

if [[ ! -d "${HOME}/.config/pm/backends" ]]; then
    command mkdir -p "${HOME}/.config/pm/backends"
fi

local new_backend_path="${HOME}/.config/pm/backends/${backend_name}.sh"

command cat > ${new_backend_path} << EOF
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
echo "Hi from '${backend_name}' backend"
EOF

command "${EDITOR:-vim}" ${new_backend_path}
