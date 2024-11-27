#!/usr/bin/env bash

function IssueHintForFullGitHistory() {
  info "Check that the local repository has the full history and that the repository is not shallow."
  if [[ "${RUN_LOCAL}" == "false" ]]; then
    info "Check that you set the 'fetch-depth: 0' option for the actions/checkout step in your GitHub Actions workflow."
  fi
  info "See https://github.com/super-linter/super-linter#get-started"
  info "Is shallow repository: $(git -C "${GITHUB_WORKSPACE}" rev-parse --is-shallow-repository)"
}
export -f IssueHintForFullGitHistory

function GenerateFileDiff() {
  local DIFF_GIT_DEFAULT_BRANCH_CMD
  DIFF_GIT_DEFAULT_BRANCH_CMD="git -C \"${GITHUB_WORKSPACE}\" diff --diff-filter=d --name-only ${DEFAULT_BRANCH}...${GITHUB_SHA} | xargs -I % sh -c 'echo \"${GITHUB_WORKSPACE}/%\"' 2>&1"

  if [ "${GITHUB_EVENT_NAME:-}" == "push" ]; then
    local DIFF_TREE_CMD
    if [[ "${GITHUB_SHA}" == "${GIT_ROOT_COMMIT_SHA}" ]]; then
      GITHUB_BEFORE_SHA=""
      debug "Set GITHUB_BEFORE_SHA (${GITHUB_BEFORE_SHA}) to an empty string because there's no commit before the initial commit to diff against."
    fi
    DIFF_TREE_CMD="git -C \"${GITHUB_WORKSPACE}\" diff-tree --no-commit-id --name-only -r --root ${GITHUB_SHA} ${GITHUB_BEFORE_SHA} | xargs -I % sh -c 'echo \"${GITHUB_WORKSPACE}/%\"' 2>&1"
    RunFileDiffCommand "${DIFF_TREE_CMD}"
    if [ ${#RAW_FILE_ARRAY[@]} -eq 0 ]; then
      debug "Generating the file array with diff-tree produced [0] items, trying with git diff against the default branch..."
      RunFileDiffCommand "${DIFF_GIT_DEFAULT_BRANCH_CMD}"
    fi
  else
    RunFileDiffCommand "${DIFF_GIT_DEFAULT_BRANCH_CMD}"
  fi
}

function RunFileDiffCommand() {
  local CMD
  CMD="${1}"
  debug "Generating Diff with:[$CMD]"

  #################################################
  # Get the Array of files changed in the commits #
  #################################################
  if ! CMD_OUTPUT=$(eval "set -eo pipefail; $CMD; set +eo pipefail"); then
    error "Failed to get Diff with:[$CMD]"
    IssueHintForFullGitHistory
    fatal "Diff command output: ${CMD_OUTPUT}"
  fi

  mapfile -t RAW_FILE_ARRAY < <(echo -n "$CMD_OUTPUT")
}

function BuildFileList() {
  debug "Building file list..."

  VALIDATE_ALL_CODEBASE="${1}"
  debug "VALIDATE_ALL_CODEBASE: ${VALIDATE_ALL_CODEBASE}"

  TEST_CASE_RUN="${2}"
  debug "TEST_CASE_RUN: ${TEST_CASE_RUN}"

  if [ "${VALIDATE_ALL_CODEBASE}" == "false" ] && [ "${TEST_CASE_RUN}" != "true" ]; then
    debug "Build the list of all changed files"

    GenerateFileDiff
  else
    if [ "${USE_FIND_ALGORITHM}" == 'true' ]; then
      debug "Populating the file list with all the files in the ${GITHUB_WORKSPACE} workspace using FIND algorithm"
      if ! mapfile -t RAW_FILE_ARRAY < <(find "${GITHUB_WORKSPACE}" \
        -not \( -path '*/\.git' -prune \) \
        -not \( -path '*/\.pytest_cache' -prune \) \
        -not \( -path '*/\.rbenv' -prune \) \
        -not \( -path '*/\.terragrunt-cache' -prune \) \
        -not \( -path '*/\.venv' -prune \) \
        -not \( -path '*/\__pycache__' -prune \) \
        -not \( -path '*/\node_modules' -prune \) \
        -not -name ".DS_Store" \
        -not -name "*.avif" \
        -not -name "*.gif" \
        -not -name "*.ico" \
        -not -name "*.jpg" \
        -not -name "*.jpeg" \
        -not -name "*.pdf" \
        -not -name "*.png" \
        -not -name "*.webp" \
        -not -name "*.woff" \
        -not -name "*.woff2" \
        -not -name "*.zip" \
        -type f \
        2>&1 | sort); then
        fatal "Failed to get a list of changed files. USE_FIND_ALGORITHM: ${USE_FIND_ALGORITHM}"
      fi

    else
      DIFF_GIT_VALIDATE_ALL_CODEBASE="git -C \"${GITHUB_WORKSPACE}\" ls-tree -r --name-only HEAD | xargs -I % sh -c \"echo ${GITHUB_WORKSPACE}/%\" 2>&1"
      debug "Populating the file list with: ${DIFF_GIT_VALIDATE_ALL_CODEBASE}"
      if ! mapfile -t RAW_FILE_ARRAY < <(eval "set -eo pipefail; ${DIFF_GIT_VALIDATE_ALL_CODEBASE}; set +eo pipefail"); then
        fatal "Failed to get a list of changed files. USE_FIND_ALGORITHM: ${USE_FIND_ALGORITHM}"
      fi
    fi
  fi

  debug "RAW_FILE_ARRAY contents: ${RAW_FILE_ARRAY[*]}"

  if [ ${#RAW_FILE_ARRAY[@]} -eq 0 ]; then
    warn "No files were found in the GITHUB_WORKSPACE:[${GITHUB_WORKSPACE}] to lint!"
  fi

  ####################################################
  # Configure linters that scan the entire workspace #
  ####################################################
  debug "Checking if we are in test mode before configuring the list of directories to lint. TEST_CASE_RUN: ${TEST_CASE_RUN}"
  if [ "${TEST_CASE_RUN}" == "true" ]; then
    debug "We are running in test mode."

    debug "Adding test case directories to the list of directories to analyze with JSCPD."
    DEFAULT_JSCPD_TEST_CASE_DIRECTORY="${GITHUB_WORKSPACE}/${TEST_CASE_FOLDER}/jscpd"
    # We need this for parallel
    export DEFAULT_JSCPD_TEST_CASE_DIRECTORY
    debug "DEFAULT_JSCPD_TEST_CASE_DIRECTORY: ${DEFAULT_JSCPD_TEST_CASE_DIRECTORY}"
    RAW_FILE_ARRAY+=("${DEFAULT_JSCPD_TEST_CASE_DIRECTORY}/bad")
    RAW_FILE_ARRAY+=("${DEFAULT_JSCPD_TEST_CASE_DIRECTORY}/good")

    debug "Adding test case directories to the list of directories to analyze with Commitlint."
    DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY="${GITHUB_WORKSPACE}/${TEST_CASE_FOLDER}/git_commitlint"
    # We need this for parallel
    export DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY
    debug "DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY: ${DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY}"
    RAW_FILE_ARRAY+=("${DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY}/bad")
    RAW_FILE_ARRAY+=("${DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY}/good")
    # Commitlint uses Git to get commit data, so the dynamically created test case repositories
    # need to be marked as safe
    git config --global --add safe.directory "${DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY}/bad"
    git config --global --add safe.directory "${DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY}/good"
  fi

  debug "Add GITHUB_WORKSPACE (${GITHUB_WORKSPACE}) to the list of files to lint because we might need it for linters that lint the whole workspace"
  RAW_FILE_ARRAY+=("${GITHUB_WORKSPACE}")

  if [ -d "${ANSIBLE_DIRECTORY}" ]; then
    debug "Adding ANSIBLE_DIRECTORY (${ANSIBLE_DIRECTORY}) to the list of files and directories to lint."
    RAW_FILE_ARRAY+=("${ANSIBLE_DIRECTORY}")
  else
    debug "ANSIBLE_DIRECTORY (${ANSIBLE_DIRECTORY}) does NOT exist."
  fi

  local PARALLEL_RESULTS_FILE_PATH
  PARALLEL_RESULTS_FILE_PATH="${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}/super-linter-parallel-results-build-file-list.json"
  debug "PARALLEL_RESULTS_FILE_PATH when building the file list: ${PARALLEL_RESULTS_FILE_PATH}"

  local -a PARALLEL_COMMAND
  PARALLEL_COMMAND=(parallel --will-cite --keep-order --max-procs "$(($(nproc) * 1))" --results "${PARALLEL_RESULTS_FILE_PATH}" --xargs)

  if [ "${LOG_DEBUG}" == "true" ]; then
    debug "LOG_DEBUG is enabled. Enable verbose ouput for parallel"
    PARALLEL_COMMAND+=(--verbose)
  fi

  # Max number of files to categorize per process
  PARALLEL_COMMAND+=(--max-lines 10)

  PARALLEL_COMMAND+=("BuildFileArrays")
  debug "PARALLEL_COMMAND to build the list of files and directories to lint: ${PARALLEL_COMMAND[*]}"

  FILE_ARRAYS_DIRECTORY_PATH="${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}/super-linter-file-arrays"
  mkdir -p "${FILE_ARRAYS_DIRECTORY_PATH}"
  export FILE_ARRAYS_DIRECTORY_PATH
  debug "Created FILE_ARRAYS_DIRECTORY_PATH: ${FILE_ARRAYS_DIRECTORY_PATH}"

  info "Building the list of files and directories to check"

  PARALLEL_COMMAND_OUTPUT=$(printf "%s\n" "${RAW_FILE_ARRAY[@]}" | "${PARALLEL_COMMAND[@]}" 2>&1)
  PARALLEL_COMMAND_RETURN_CODE=$?
  debug "PARALLEL_COMMAND_OUTPUT to build the file list (exit code: ${PARALLEL_COMMAND_RETURN_CODE}):\n${PARALLEL_COMMAND_OUTPUT}"
  debug "Parallel output file (${PARALLEL_RESULTS_FILE_PATH}) contents when building the file list:\n$(cat "${PARALLEL_RESULTS_FILE_PATH}")"

  local RESULTS_OBJECT
  RESULTS_OBJECT=
  if ! RESULTS_OBJECT=$(jq --raw-output -n '[inputs]' "${PARALLEL_RESULTS_FILE_PATH}"); then
    fatal "Error loading results when building the file list: ${RESULTS_OBJECT}"
  fi
  debug "RESULTS_OBJECT when building the file list:\n${RESULTS_OBJECT}"

  local STDOUT_BUILD_FILE_LIST
  # Get raw output so we can strip quotes from the data we load
  if ! STDOUT_BUILD_FILE_LIST="$(jq --raw-output '.[] | select(.Stdout[:-1] | length > 0) | .Stdout[:-1]' <<<"${RESULTS_OBJECT}")"; then
    fatal "Error when loading stdout when building the file list: ${STDOUT_BUILD_FILE_LIST}"
  fi

  if [ -n "${STDOUT_BUILD_FILE_LIST}" ]; then
    info "Command output when building the file list:\n------\n${STDOUT_BUILD_FILE_LIST}\n------"
  else
    debug "Stdout when building the file list is empty"
  fi

  local STDERR_BUILD_FILE_LIST
  if ! STDERR_BUILD_FILE_LIST="$(jq --raw-output '.[] | select(.Stderr[:-1] | length > 0) | .Stderr[:-1]' <<<"${RESULTS_OBJECT}")"; then
    fatal "Error when loading stderr when building the file list:\n${STDERR_BUILD_FILE_LIST}"
  fi

  if [ -n "${STDERR_BUILD_FILE_LIST}" ]; then
    info "Stderr when building the file list:\n------\n${STDERR_BUILD_FILE_LIST}\n------"
  else
    debug "Stderr when building the file list is empty"
  fi

  if [[ ${PARALLEL_COMMAND_RETURN_CODE} -ne 0 ]]; then
    fatal "Error when building the list of files and directories to lint."
  fi

  ################
  # Footer print #
  ################
  info "Successfully gathered list of files..."
}

BuildFileArrays() {
  local -a RAW_FILE_ARRAY
  RAW_FILE_ARRAY=("$@")

  debug "Categorizing the following files: ${RAW_FILE_ARRAY[*]}"
  debug "FILTER_REGEX_INCLUDE: ${FILTER_REGEX_INCLUDE}, FILTER_REGEX_EXCLUDE: ${FILTER_REGEX_EXCLUDE}, TEST_CASE_RUN: ${TEST_CASE_RUN}"

  for FILE in "${RAW_FILE_ARRAY[@]}"; do
    # Get the file extension
    FILE_TYPE="$(GetFileExtension "$FILE")"
    # We want a lowercase value
    local -l BASE_FILE
    # Get the name of the file and the containing directory path
    BASE_FILE=$(basename "${FILE}")
    FILE_DIR_NAME="$(dirname "${FILE}")"

    debug "FILE: ${FILE}, FILE_TYPE: ${FILE_TYPE}, BASE_FILE: ${BASE_FILE}, FILE_DIR_NAME: ${FILE_DIR_NAME}"

    if [ ! -e "${FILE}" ]; then
      # File not found in workspace
      warn "{$FILE} exists in commit data, but not found on file system, skipping..."
      continue
    fi

    # Handle the corner cases of linters that are expected to lint the whole codebase,
    # but we don't have a variable to explicitly set the directory
    # to lint.
    if [[ "${FILE}" == "${GITHUB_WORKSPACE}" ]]; then
      debug "${FILE} matches with ${GITHUB_WORKSPACE}. Adding it to the list of directories to lint for linters that are expected to lint the whole codebase"

      if CheckovConfigurationFileContainsDirectoryOption "${CHECKOV_LINTER_RULES}"; then
        debug "No need to configure the directories to check for Checkov because its configuration file contains the list of directories to analyze."
        debug "Add the Checkov configuration file path to the list of items to check to consume as output later."
        echo "${CHECKOV_LINTER_RULES}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CHECKOV"
      else
        debug "Adding ${GITHUB_WORKSPACE} to the list of directories to analyze with Checkov."
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CHECKOV"
      fi

      # Test cases for these languages are handled below because we first need to exclude non-relevant test cases
      if [[ "${TEST_CASE_RUN}" == "false" ]]; then
        debug "Add ${FILE} to the list of items to lint with JSCPD"
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSCPD"

        debug "Add ${FILE} to the list of items to lint with Commitlint"
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GIT_COMMITLINT"
      fi

      # Handle the corner case where FILE=${GITHUB_WORKSPACE}, and the user set
      # ANSIBLE_DIRECTORY=. or ANSIBLE_DIRECTORY=/
      if IsAnsibleDirectory "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-ANSIBLE"
      fi

      debug "No need to further process ${FILE}"
      continue
    fi

    ###############################################
    # Filter files if FILTER_REGEX_INCLUDE is set #
    ###############################################
    if [[ -n "$FILTER_REGEX_INCLUDE" ]] && [[ ! (${FILE} =~ $FILTER_REGEX_INCLUDE) ]]; then
      debug "FILTER_REGEX_INCLUDE didn't match. Skipping ${FILE}"
      continue
    fi

    ###############################################
    # Filter files if FILTER_REGEX_EXCLUDE is set #
    ###############################################
    if [[ -n "$FILTER_REGEX_EXCLUDE" ]] && [[ ${FILE} =~ $FILTER_REGEX_EXCLUDE ]]; then
      debug "FILTER_REGEX_EXCLUDE match. Skipping ${FILE}"
      continue
    fi

    ###################################################
    # Filter files if FILTER_REGEX_EXCLUDE is not set #
    ###################################################
    if [ "${IGNORE_GITIGNORED_FILES}" == "true" ] && git -C "${GITHUB_WORKSPACE}" check-ignore "$FILE"; then
      debug "${FILE} is ignored by Git. Skipping ${FILE}"
      continue
    fi

    #########################################
    # Filter files with at-generated marker #
    #########################################
    if [ "${IGNORE_GENERATED_FILES}" == "true" ] && IsGenerated "$FILE"; then
      debug "${FILE} is generated. Skipping ${FILE}"
      continue
    fi

    # These linters check every file
    local EDITORCONFIG_FILE_PATH
    EDITORCONFIG_FILE_PATH="${GITHUB_WORKSPACE}/.editorconfig"
    if [ -e "${EDITORCONFIG_FILE_PATH}" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-EDITORCONFIG"
    else
      debug "Don't include ${FILE} in the list of files to lint with editorconfig-checker because the workspace doesn't contain an EditorConfig file: ${EDITORCONFIG_FILE_PATH}"
    fi

    echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GIT_MERGE_CONFLICT_MARKERS"
    echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GITLEAKS"

    if IsAnsibleDirectory "${FILE}"; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-ANSIBLE"
    fi

    # Handle JSCPD test cases
    # At this point, we already processed the options to include or exclude files, so we
    # excluded test cases that are not relevant
    if [[ "${TEST_CASE_RUN}" == "true" ]] && [[ "${FILE}" =~ .*${DEFAULT_JSCPD_TEST_CASE_DIRECTORY}.* ]] && [[ -d "${FILE}" ]]; then
      debug "${FILE} is a test case for JSCPD. Adding it to the list of items to lint with JSCPD"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSCPD"
    fi

    # Handle Commitlint test cases
    if [[ "${TEST_CASE_RUN}" == "true" ]] && [[ "${FILE}" =~ .*${DEFAULT_GIT_COMMITLINT_TEST_CASE_DIRECTORY}.* ]] && [[ -d "${FILE}" ]]; then
      debug "${FILE} is a test case for Commitlint. Adding it to the list of items to lint with Commitlint"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GIT_COMMITLINT"
    fi

    # See https://docs.renovatebot.com/configuration-options/
    if [[ "${BASE_FILE}" =~ renovate.json5? ]] ||
      [ "${BASE_FILE}" == ".renovaterc" ] || [[ "${BASE_FILE}" =~ .renovaterc.json5? ]]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RENOVATE"
    fi

    # See https://docs.renovatebot.com/config-presets/
    IFS="," read -r -a RENOVATE_SHAREABLE_CONFIG_PRESET_FILE_NAMES_ARRAY <<<"${RENOVATE_SHAREABLE_CONFIG_PRESET_FILE_NAMES}"
    for file_name in "${RENOVATE_SHAREABLE_CONFIG_PRESET_FILE_NAMES_ARRAY[@]}"; do
      if [ "${BASE_FILE}" == "${file_name}" ]; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RENOVATE"
        break
      fi
    done

    if IsValidShellScript "${FILE}"; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-BASH"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-BASH_EXEC"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-SHELL_SHFMT"
    elif [ "${FILE_TYPE}" == "clj" ] || [ "${FILE_TYPE}" == "cljs" ] ||
      [ "${FILE_TYPE}" == "cljc" ] || [ "${FILE_TYPE}" == "edn" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CLOJURE"
    elif [ "${FILE_TYPE}" == "cpp" ] || [ "${FILE_TYPE}" == "h" ] ||
      [ "${FILE_TYPE}" == "cc" ] || [ "${FILE_TYPE}" == "hpp" ] ||
      [ "${FILE_TYPE}" == "cxx" ] || [ "${FILE_TYPE}" == "cu" ] ||
      [ "${FILE_TYPE}" == "hxx" ] || [ "${FILE_TYPE}" == "c++" ] ||
      [ "${FILE_TYPE}" == "hh" ] || [ "${FILE_TYPE}" == "h++" ] ||
      [ "${FILE_TYPE}" == "cuh" ] || [ "${FILE_TYPE}" == "c" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CPP"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CLANG_FORMAT"
    elif [ "${FILE_TYPE}" == "coffee" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-COFFEESCRIPT"
    elif [ "${FILE_TYPE}" == "cs" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CSHARP"
    elif [ "${FILE_TYPE}" == "css" ] || [ "${FILE_TYPE}" == "scss" ] ||
      [ "${FILE_TYPE}" == "sass" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CSS"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CSS_PRETTIER"
    elif [ "${FILE_TYPE}" == "dart" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-DART"
    # Use BASE_FILE here because FILE_TYPE is not reliable when there is no file extension
    elif [[ "${FILE_TYPE}" != "tap" ]] && [[ "${FILE_TYPE}" != "yml" ]] &&
      [[ "${FILE_TYPE}" != "yaml" ]] && [[ "${FILE_TYPE}" != "json" ]] &&
      [[ "${FILE_TYPE}" != "xml" ]] &&
      [[ "${BASE_FILE}" =~ ^(.+\.)?(contain|dock)erfile$ ]]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-DOCKERFILE_HADOLINT"
    elif [ "${FILE_TYPE}" == "env" ] || [[ "${BASE_FILE}" == *".env."* ]]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-ENV"
    elif [ "${FILE_TYPE}" == "feature" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GHERKIN"
    elif [ "${FILE_TYPE}" == "go" ] ||
      [[ "${BASE_FILE}" == "go.mod" ]]; then

      # Check if we should lint a Go module
      local GO_MOD_FILE_PATH=""
      if [ "${BASE_FILE}" == "go.mod" ]; then
        GO_MOD_FILE_PATH="${FILE}"
        debug "${BASE_FILE} is a Go module file. Setting the go.mod file path to ${GO_MOD_FILE_PATH}"
      else
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GO"
        debug "${BASE_FILE} is a Go file. Trying to find out if it's part of a Go module"
        local dir_name
        dir_name="${FILE_DIR_NAME}"
        while [ "${dir_name}" != "$(dirname "${GITHUB_WORKSPACE}")" ] && [ "${dir_name}" != "/" ]; do
          local potential_go_mod_file_path="${dir_name}/go.mod"
          if [ -f "${potential_go_mod_file_path}" ]; then
            GO_MOD_FILE_PATH="${potential_go_mod_file_path}"
            break
          fi
          dir_name=$(dirname "${dir_name}")
        done
      fi

      if [[ -n "${GO_MOD_FILE_PATH:-}" ]]; then
        debug "Considering ${FILE_DIR_NAME} as a Go module because it contains ${GO_MOD_FILE_PATH}"
        local FILE_ARRAY_GO_MODULES_PATH="${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GO_MODULES"

        if [[ ! -e "${FILE_ARRAY_GO_MODULES_PATH}" ]] || ! grep -Fxq "${FILE_DIR_NAME}" "${FILE_ARRAY_GO_MODULES_PATH}"; then
          echo "${FILE_DIR_NAME}" >>"${FILE_ARRAY_GO_MODULES_PATH}"
          debug "Added ${GO_MOD_FILE_PATH} directory (${FILE_DIR_NAME}) to the list of Go modules to lint"
        else
          debug "Skip adding ${GO_MOD_FILE_PATH} directory (${FILE_DIR_NAME}) to the list of Go modules to lint because it's already in that list"
        fi
      else
        debug "${FILE} is not considered to be part of a Go module"
      fi
    # Use BASE_FILE here because FILE_TYPE is not reliable when there is no file extension
    elif [ "$FILE_TYPE" == "groovy" ] || [ "$FILE_TYPE" == "jenkinsfile" ] ||
      [ "$FILE_TYPE" == "gradle" ] || [ "$FILE_TYPE" == "nf" ] ||
      [[ "$BASE_FILE" =~ .*jenkinsfile.* ]]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GROOVY"
    elif [ "${FILE_TYPE}" == "html" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-HTML"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-HTML_PRETTIER"
    elif [ "${FILE_TYPE}" == "java" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JAVA"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GOOGLE_JAVA_FORMAT"
    elif [ "${FILE_TYPE}" == "js" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JAVASCRIPT_BIOME"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JAVASCRIPT_ES"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JAVASCRIPT_STANDARD"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JAVASCRIPT_PRETTIER"
    elif [ "$FILE_TYPE" == "jsonc" ] || [ "$FILE_TYPE" == "json5" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSONC"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSONC_PRETTIER"
    elif [ "${FILE_TYPE}" == "json" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSON"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSON_PRETTIER"
      if DetectOpenAPIFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-OPENAPI"
      fi

      if DetectARMFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-ARM"
      fi

      if DetectCloudFormationFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CLOUDFORMATION"
      fi

      if DetectAWSStatesFIle "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-STATES"
      fi
    elif [ "${FILE_TYPE}" == "jsx" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSX"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-JSX_PRETTIER"
    elif [ "${FILE_TYPE}" == "kt" ] || [ "${FILE_TYPE}" == "kts" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-KOTLIN"
    elif [ "$FILE_TYPE" == "lua" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-LUA"
    elif [ "${FILE_TYPE}" == "tex" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-LATEX"
    elif [ "${FILE_TYPE}" == "md" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-MARKDOWN"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-MARKDOWN_PRETTIER"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-NATURAL_LANGUAGE"
    elif [ "${FILE_TYPE}" == "php" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PHP_BUILTIN"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PHP_PHPCS"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PHP_PHPSTAN"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PHP_PSALM"
    elif [ "${FILE_TYPE}" == "pl" ] || [ "${FILE_TYPE}" == "pm" ] ||
      [ "${FILE_TYPE}" == "t" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PERL"
    elif [ "${FILE_TYPE}" == "ps1" ] ||
      [ "${FILE_TYPE}" == "psm1" ] ||
      [ "${FILE_TYPE}" == "psd1" ] ||
      [ "${FILE_TYPE}" == "ps1xml" ] ||
      [ "${FILE_TYPE}" == "pssc" ] ||
      [ "${FILE_TYPE}" == "psrc" ] ||
      [ "${FILE_TYPE}" == "cdxml" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-POWERSHELL"
    elif [ "${FILE_TYPE}" == "proto" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PROTOBUF"
    elif [ "${FILE_TYPE}" == "py" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_BLACK"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_FLAKE8"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_ISORT"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_PYLINT"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_MYPY"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_PYINK"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-PYTHON_RUFF"
    elif [ "${FILE_TYPE}" == "raku" ] || [ "${FILE_TYPE}" == "rakumod" ] ||
      [ "${FILE_TYPE}" == "rakutest" ] || [ "${FILE_TYPE}" == "pm6" ] ||
      [ "${FILE_TYPE}" == "pl6" ] || [ "${FILE_TYPE}" == "p6" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RAKU"
    elif [ "${FILE_TYPE}" == "r" ] || [ "${FILE_TYPE}" == "rmd" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-R"
    elif [ "${FILE_TYPE}" == "rb" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RUBY"
    elif [ "${FILE_TYPE}" == "rs" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RUST_2015"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RUST_2018"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RUST_2021"
    elif [ "${BASE_FILE}" == "cargo.toml" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-RUST_CLIPPY"
    elif [ "${FILE_TYPE}" == "scala" ] || [ "${FILE_TYPE}" == "sc" ] || [ "${BASE_FILE}" == "??????" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-SCALAFMT"
    elif [ "${FILE_TYPE}" == "smk" ] || [ "${BASE_FILE}" == "snakefile" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-SNAKEMAKE_LINT"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-SNAKEMAKE_SNAKEFMT"
    elif [ "${FILE_TYPE}" == "sql" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-SQLFLUFF"
    elif [ "${FILE_TYPE}" == "tf" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TERRAFORM_TFLINT"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TERRAFORM_TERRASCAN"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TERRAFORM_FMT"
    elif [ "${FILE_TYPE}" == "hcl" ] &&
      [[ ${FILE} != *".tflint.hcl"* ]] &&
      [[ ${FILE} != *".pkr.hcl"* ]] &&
      [[ ${FILE} != *"docker-bake.hcl"* ]] &&
      [[ ${FILE} != *"docker-bake.override.hcl"* ]]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TERRAGRUNT"
    elif [ "${FILE_TYPE}" == "ts" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TYPESCRIPT_BIOME"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TYPESCRIPT_ES"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TYPESCRIPT_STANDARD"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TYPESCRIPT_PRETTIER"
    elif [ "${FILE_TYPE}" == "tsx" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TSX"
    elif [ "${FILE_TYPE}" == "txt" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TXT"
    elif [ "${FILE_TYPE}" == "xml" ] ||
      [ "${FILE_TYPE}" == "xsd" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-XML"
    elif [[ "${FILE}" =~ .?goreleaser.+ya?ml ]]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GO_RELEASER"
    elif [ "${FILE_TYPE}" == "graphql" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GRAPHQL_PRETTIER"
    elif [ "${FILE_TYPE}" == "vue" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-VUE_PRETTIER"
    elif [ "${FILE_TYPE}" == "sln" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-DOTNET_SLN_FORMAT_ANALYZERS"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-DOTNET_SLN_FORMAT_STYLE"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-DOTNET_SLN_FORMAT_WHITESPACE"
    elif [ "${FILE_TYPE}" == "yml" ] || [ "${FILE_TYPE}" == "yaml" ]; then
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-YAML"
      echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-YAML_PRETTIER"
      if DetectActions "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-GITHUB_ACTIONS"
      fi

      if DetectCloudFormationFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-CLOUDFORMATION"
      fi

      if DetectOpenAPIFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-OPENAPI"
      fi

      if DetectTektonFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-TEKTON"
      fi

      if DetectKubernetesFile "${FILE}"; then
        echo "${FILE}" >>"${FILE_ARRAYS_DIRECTORY_PATH}/file-array-KUBERNETES_KUBECONFORM"
      fi
    else
      CheckFileType "${FILE}"
    fi
  done
}

# We need this for parallel
export -f BuildFileArrays
