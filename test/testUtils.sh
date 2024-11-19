#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Default log level
# shellcheck disable=SC2034
LOG_LEVEL="DEBUG"

# Create log file by default
# shellcheck disable=SC2034
CREATE_LOG_FILE="true"

# shellcheck source=/dev/null
source "lib/functions/log.sh"

# shellcheck source=/dev/null
source "lib/globals/languages.sh"

# Because we need variables defined there
# shellcheck source=/dev/null
source "lib/functions/output.sh"

# TODO: use TEST_CASE_FOLDER instead of redefining this after we extract the
# initialization of TEST_CASE_FOLDER from linter.sh
# shellcheck disable=SC2034
LINTERS_TEST_CASE_DIRECTORY="test/linters"

# shellcheck disable=SC2034
LANGUAGES_WITH_FIX_MODE=(
  "ANSIBLE"
  "CLANG_FORMAT"
  "CSHARP"
  "CSS"
  "CSS_PRETTIER"
  "DOTNET_SLN_FORMAT_ANALYZERS"
  "DOTNET_SLN_FORMAT_STYLE"
  "DOTNET_SLN_FORMAT_WHITESPACE"
  "ENV"
  "GO_MODULES"
  "GO"
  "GOOGLE_JAVA_FORMAT"
  "GROOVY"
  "GRAPHQL_PRETTIER"
  "HTML_PRETTIER"
  "JAVASCRIPT_ES"
  "JAVASCRIPT_PRETTIER"
  "JAVASCRIPT_STANDARD"
  "JSON"
  "JSON_PRETTIER"
  "JSONC"
  "JSONC_PRETTIER"
  "JSX"
  "JSX_PRETTIER"
  "MARKDOWN"
  "MARKDOWN_PRETTIER"
  "NATURAL_LANGUAGE"
  "POWERSHELL"
  "PROTOBUF"
  "PYTHON_BLACK"
  "PYTHON_ISORT"
  "PYTHON_PYINK"
  "PYTHON_RUFF"
  "RUBY"
  "RUST_2015"
  "RUST_2018"
  "RUST_2021"
  "RUST_CLIPPY"
  "SCALAFMT"
  "SHELL_SHFMT"
  "SNAKEMAKE_SNAKEFMT"
  "SQLFLUFF"
  "TERRAFORM_FMT"
  "TSX"
  "TYPESCRIPT_ES"
  "TYPESCRIPT_PRETTIER"
  "TYPESCRIPT_STANDARD"
  "VUE_PRETTIER"
  "YAML_PRETTIER"
)

# TODO: extract this list from linter.sh (see REMOVE_ARRAY) instead of
# redefining it here
# shellcheck disable=SC2034
LANGUAGES_NOT_IN_SLIM_IMAGE=(
  "ARM"
  "CSHARP"
  "DOTNET_SLN_FORMAT_ANALYZERS"
  "DOTNET_SLN_FORMAT_STYLE"
  "DOTNET_SLN_FORMAT_WHITESPACE"
  "POWERSHELL"
  "RUST_2015"
  "RUST_2018"
  "RUST_2021"
  "RUST_CLIPPY"
)

DEFAULT_BRANCH="main"

function AssertArraysElementsContentMatch() {
  local ARRAY_1_VARIABLE_NAME="${1}"
  local ARRAY_2_VARIABLE_NAME="${2}"
  local -n ARRAY_1="${ARRAY_1_VARIABLE_NAME}"
  local -n ARRAY_2="${ARRAY_2_VARIABLE_NAME}"
  if [[ "${ARRAY_1[*]}" == "${ARRAY_2[*]}" ]]; then
    debug "${ARRAY_1_VARIABLE_NAME} (${ARRAY_1[*]}) matches the expected value: ${ARRAY_2[*]}"
    RETURN_CODE=0
  else
    error "${ARRAY_1_VARIABLE_NAME} (${ARRAY_1[*]}) doesn't match the expected value: ${ARRAY_2[*]}"
    RETURN_CODE=1
  fi
  unset -n ARRAY_1
  unset -n ARRAY_2
  return ${RETURN_CODE}
}

function CheckUnexpectedGitChanges() {
  local GIT_REPOSITORY_PATH="${1}"
  # Check if there are unexpected changes in the working directory:
  # - Unstaged changes
  # - Changes that are staged but not committed
  # - Untracked files and directories
  if ! git -C "${GIT_REPOSITORY_PATH}" diff --exit-code --quiet ||
    ! git -C "${GIT_REPOSITORY_PATH}" diff --cached --exit-code --quiet ||
    ! git -C "${GIT_REPOSITORY_PATH}" ls-files --others --exclude-standard --directory; then
    echo "There are unexpected changes in the working directory of the ${GIT_REPOSITORY_PATH} Git repository."
    git -C "${GIT_REPOSITORY_PATH}" status
    return 1
  fi
}

AssertFileAndDirContentsMatch() {
  local FILE_1_PATH="${1}"
  local FILE_2_PATH="${2}"
  if diff -r "${FILE_1_PATH}" "${FILE_2_PATH}"; then
    echo "${FILE_1_PATH} contents match with ${FILE_2_PATH} contents"
    return 0
  else
    echo "${FILE_1_PATH} contents don't match with ${FILE_2_PATH} contents"
    return 1
  fi
}

AssertFileContentsMatchIgnoreHtmlComments() {
  local FILE_1_PATH="${1}"
  local FILE_2_PATH="${2}"
  # Use cat -s to remove duplicate blank lines because Prettier adds blank
  # lines after HTML comments in Markdown files
  if diff "${FILE_1_PATH}" <(grep -vE '^\s*<!--' "${FILE_2_PATH}" | cat -s); then
    echo "${FILE_1_PATH} contents match with ${FILE_2_PATH} contents"
    return 0
  else
    echo "${FILE_1_PATH} contents don't match with ${FILE_2_PATH} contents"
    return 1
  fi
}

IsLanguageInSlimImage() {
  local LANGUAGE="${1}"
  if [[ " ${LANGUAGES_NOT_IN_SLIM_IMAGE[*]} " =~ [[:space:]]${LANGUAGE}[[:space:]] ]]; then
    debug "${LANGUAGE} is not available in the Super-linter slim image"
    return 1
  else
    debug "${LANGUAGE} is available in the Super-linter slim image"
    return 0
  fi
}

IsStandardImage() {
  if [[ "${IMAGE}" == "standard" ]]; then
    debug "This is the standard image"
    return 0
  else
    debug "This isn't the standard image"
    return 1
  fi
}

AreAnsiColorCodesInFile() {
  local FILE_TO_SEARCH_IN="${1}"
  if grep --color=never --quiet --perl-regexp "${ANSI_COLOR_CODES_SEARCH_PATTERN}" "${FILE_TO_SEARCH_IN}"; then
    debug "Found at least one ANSI color code in ${FILE_TO_SEARCH_IN}"
    return 0
  else
    debug "Found no ANSI color codes in ${FILE_TO_SEARCH_IN}"
    return 1
  fi
}

RemoveTestLeftovers() {
  local LEFTOVERS_TO_CLEAN=()
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_WORKSPACE}/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/bad/target")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_WORKSPACE}/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/bad/Cargo.lock")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_WORKSPACE}/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/good/target")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_WORKSPACE}/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/good/Cargo.lock")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_WORKSPACE}/dependencies/composer/vendor")
  # Delete leftovers in pwd in case the workspace is not pwd
  LEFTOVERS_TO_CLEAN+=("$(pwd)/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/bad/target")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/bad/Cargo.lock")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/good/target")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/${LINTERS_TEST_CASE_DIRECTORY}/rust_clippy/good/Cargo.lock")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/dependencies/composer/vendor")

  debug "Cleaning eventual test leftovers: ${LEFTOVERS_TO_CLEAN[*]}"
  sudo rm -rf "${LEFTOVERS_TO_CLEAN[@]}"
}

RemoveTestLogsAndSuperLinterOutputs() {
  local LEFTOVERS_TO_CLEAN=()
  LEFTOVERS_TO_CLEAN+=("${LOG_FILE_PATH}")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_GITHUB_STEP_SUMMARY_FILE_PATH}")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_MAIN_OUTPUT_PATH}")
  LEFTOVERS_TO_CLEAN+=("${SUPER_LINTER_SUMMARY_FILE_PATH}")

  LEFTOVERS_TO_CLEAN+=("$(pwd)/$(basename "${LOG_FILE_PATH}")")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/$(basename "${SUPER_LINTER_GITHUB_STEP_SUMMARY_FILE_PATH}")")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/$(basename "${SUPER_LINTER_MAIN_OUTPUT_PATH}")")
  LEFTOVERS_TO_CLEAN+=("$(pwd)/$(basename "${SUPER_LINTER_SUMMARY_FILE_PATH}")")

  debug "Cleaning eventual test logs and Super-linter outputs leftovers: ${LEFTOVERS_TO_CLEAN[*]}"
  sudo rm -rf "${LEFTOVERS_TO_CLEAN[@]}"
}

initialize_git_repository() {
  local GIT_REPOSITORY_PATH="${1}"

  # Assuming that if sudo is available we aren't running inside a container,
  # so we don't want to leave leftovers around.
  if command -v sudo; then
    # shellcheck disable=SC2064 # Once the path is set, we don't expect it to change
    trap "sudo rm -fr '${GIT_REPOSITORY_PATH}'" EXIT
  fi

  if [[ ! -d "${GIT_REPOSITORY_PATH}" ]]; then
    mkdir --parents "${GIT_REPOSITORY_PATH}"
  fi

  debug "GIT_REPOSITORY_PATH: ${GIT_REPOSITORY_PATH}"

  git -C "${GIT_REPOSITORY_PATH}" init --initial-branch="${DEFAULT_BRANCH:-"main"}"
  git -C "${GIT_REPOSITORY_PATH}" config user.name "Super-linter Test"
  git -C "${GIT_REPOSITORY_PATH}" config user.email "super-linter-test@example.com"
}

git_log_graph() {
  local GIT_REPOSITORY_PATH="${1}"

  git -C "${GIT_REPOSITORY_PATH}" log \
    --abbrev-commit \
    --all \
    --decorate \
    --format=oneline \
    --graph
}
