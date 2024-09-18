# BEWARE: This is a default template. It is managed internally and may be overridden!
#
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

cargo new --"${PM_CARGO_TEMPLATE:-"bin"}" "${PROJECT}"
