# Information about the project are passed as environment variables in the following way:
#
# SPACE        - name of the space the project must be created in.
#
# SPACE_PATH   - absolute path to the space directory. It corresponds to the
#                following pattern evaluated: ${HOME}/${PM_HOME}/${SPACE}.
#
# PROJECT      - name of the project that must be created.
#
# PROJECT_PATH - absolute path to the project directory. It corresponds to the
#                following pattern evaluated: ${SPACE_PATH}/${PROJECT}.
cd "${SPACE_PATH}"

mix new "${PROJECT}"

git -C "${PROJECT_PATH}" init
