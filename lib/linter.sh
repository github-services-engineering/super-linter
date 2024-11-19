#!/usr/bin/env bash

set -o nounset
set -o pipefail

# Version of the Super-linter (standard,slim,etc)
IMAGE="${IMAGE:-standard}"

#########################
# Source Function Files #
#########################
# Source log functions and variables early so we can use them ASAP
# shellcheck source=/dev/null
source /action/lib/functions/log.sh # Source the function script(s)

# shellcheck source=/dev/null
source /action/lib/functions/buildFileList.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/detectFiles.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/linterRules.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/updateSSL.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/validation.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/worker.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/setupSSH.sh # Source the function script(s)
# shellcheck source=/dev/null
source /action/lib/functions/githubEvent.sh
# shellcheck source=/dev/null
source /action/lib/functions/githubDomain.sh
# shellcheck source=/dev/null
source /action/lib/functions/output.sh

if ! ValidateGitHubUrls; then
  fatal "GitHub URLs failed validation"
fi

# We want a lowercase value
declare -l RUN_LOCAL
# Initialize RUN_LOCAL early because we need it for logging
RUN_LOCAL="${RUN_LOCAL:-"false"}"

# Dynamically set the default behavior for GitHub Actions log markers because
# we want to give users a chance to enable this even when running locally, but
# we still want to provide a default value in case they don't want to explictly
# configure it.
if [[ "${RUN_LOCAL}" == "true" ]]; then
  DEFAULT_ENABLE_GITHUB_ACTIONS_GROUP_TITLE="false"
  DEFAULT_ENABLE_GITHUB_ACTIONS_STEP_SUMMARY="false"
else
  DEFAULT_ENABLE_GITHUB_ACTIONS_GROUP_TITLE="true"
  DEFAULT_ENABLE_GITHUB_ACTIONS_STEP_SUMMARY="true"
fi
# Let users configure GitHub Actions log markers regardless of running locally or not
ENABLE_GITHUB_ACTIONS_GROUP_TITLE="${ENABLE_GITHUB_ACTIONS_GROUP_TITLE:-"${DEFAULT_ENABLE_GITHUB_ACTIONS_GROUP_TITLE}"}"
export ENABLE_GITHUB_ACTIONS_GROUP_TITLE

startGitHubActionsLogGroup "${SUPER_LINTER_INITIALIZATION_LOG_GROUP_TITLE}"

# Let users configure GitHub Actions step summary regardless of running locally or not
ENABLE_GITHUB_ACTIONS_STEP_SUMMARY="${ENABLE_GITHUB_ACTIONS_STEP_SUMMARY:-"${DEFAULT_ENABLE_GITHUB_ACTIONS_STEP_SUMMARY}"}"
export ENABLE_GITHUB_ACTIONS_STEP_SUMMARY

# We want a lowercase value
declare -l BASH_EXEC_IGNORE_LIBRARIES
BASH_EXEC_IGNORE_LIBRARIES="${BASH_EXEC_IGNORE_LIBRARIES:-false}"

# We want a lowercase value
declare -l DISABLE_ERRORS
DISABLE_ERRORS="${DISABLE_ERRORS:-"false"}"

# We want a lowercase value
declare -l IGNORE_GENERATED_FILES
# Do not ignore generated files by default for backwards compatibility
IGNORE_GENERATED_FILES="${IGNORE_GENERATED_FILES:-false}"
export IGNORE_GENERATED_FILES

# We want a lowercase value
declare -l IGNORE_GITIGNORED_FILES
IGNORE_GITIGNORED_FILES="${IGNORE_GITIGNORED_FILES:-false}"
export IGNORE_GITIGNORED_FILES

# We want a lowercase value
declare -l MULTI_STATUS
MULTI_STATUS="${MULTI_STATUS:-true}"

# We want a lowercase value
declare -l SAVE_SUPER_LINTER_OUTPUT
SAVE_SUPER_LINTER_OUTPUT="${SAVE_SUPER_LINTER_OUTPUT:-false}"

# We want a lowercase value
declare -l SSH_INSECURE_NO_VERIFY_GITHUB_KEY
SSH_INSECURE_NO_VERIFY_GITHUB_KEY="${SSH_INSECURE_NO_VERIFY_GITHUB_KEY:-false}"

# We want a lowercase value
declare -l SSH_SETUP_GITHUB
SSH_SETUP_GITHUB="${SSH_SETUP_GITHUB:-false}"

# We want a lowercase value
declare -l SUPPRESS_FILE_TYPE_WARN
SUPPRESS_FILE_TYPE_WARN="${SUPPRESS_FILE_TYPE_WARN:-false}"

# We want a lowercase value
declare -l SUPPRESS_POSSUM
SUPPRESS_POSSUM="${SUPPRESS_POSSUM:-false}"

# We want a lowercase value
declare -l TEST_CASE_RUN
# Option to tell code to run only test cases
TEST_CASE_RUN="${TEST_CASE_RUN:-"false"}"
export TEST_CASE_RUN

declare -l FIX_MODE_TEST_CASE_RUN
FIX_MODE_TEST_CASE_RUN="${FIX_MODE_TEST_CASE_RUN:-"false"}"
export FIX_MODE_TEST_CASE_RUN

# We want a lowercase value
declare -l USE_FIND_ALGORITHM
USE_FIND_ALGORITHM="${USE_FIND_ALGORITHM:-false}"

# We want a lowercase value
declare -l VALIDATE_ALL_CODEBASE
VALIDATE_ALL_CODEBASE="${VALIDATE_ALL_CODEBASE:-"true"}"

# We want a lowercase value
declare -l YAML_ERROR_ON_WARNING
YAML_ERROR_ON_WARNING="${YAML_ERROR_ON_WARNING:-false}"

# We want a lowercase value
declare -l SAVE_SUPER_LINTER_SUMMARY
SAVE_SUPER_LINTER_SUMMARY="${SAVE_SUPER_LINTER_SUMMARY:-false}"

declare -l REMOVE_ANSI_COLOR_CODES_FROM_OUTPUT
REMOVE_ANSI_COLOR_CODES_FROM_OUTPUT="${REMOVE_ANSI_COLOR_CODES_FROM_OUTPUT:-"false"}"
export REMOVE_ANSI_COLOR_CODES_FROM_OUTPUT

declare -l ENABLE_COMMITLINT_STRICT_MODE
ENABLE_COMMITLINT_STRICT_MODE="${ENABLE_COMMITLINT_STRICT_MODE:-"false"}"
export ENABLE_COMMITLINT_STRICT_MODE

declare -l ENFORCE_COMMITLINT_CONFIGURATION_CHECK
ENFORCE_COMMITLINT_CONFIGURATION_CHECK="${ENFORCE_COMMITLINT_CONFIGURATION_CHECK:-"false"}"
export ENFORCE_COMMITLINT_CONFIGURATION_CHECK

# Define private output paths early because cleanup depends on those being defined
DEFAULT_SUPER_LINTER_OUTPUT_DIRECTORY_NAME="super-linter-output"
SUPER_LINTER_OUTPUT_DIRECTORY_NAME="${SUPER_LINTER_OUTPUT_DIRECTORY_NAME:-${DEFAULT_SUPER_LINTER_OUTPUT_DIRECTORY_NAME}}"
export SUPER_LINTER_OUTPUT_DIRECTORY_NAME
debug "Super-linter main output directory name: ${SUPER_LINTER_OUTPUT_DIRECTORY_NAME}"

SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH="/tmp/${DEFAULT_SUPER_LINTER_OUTPUT_DIRECTORY_NAME}"
export SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH
debug "Super-linter private output directory path: ${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}"
mkdir -p "${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}"

FIX_MODE_ENABLED="false"

ValidateBooleanConfigurationVariables

###########
# GLOBALS #
###########
DEFAULT_RULES_LOCATION='/action/lib/.automation'                            # Default rules files location
DEFAULT_SUPER_LINTER_WORKSPACE="/tmp/lint"                                  # Fall-back value for the workspace
DEFAULT_WORKSPACE="${DEFAULT_WORKSPACE:-${DEFAULT_SUPER_LINTER_WORKSPACE}}" # Default workspace if running locally
FILTER_REGEX_INCLUDE="${FILTER_REGEX_INCLUDE:-""}"
export FILTER_REGEX_INCLUDE
FILTER_REGEX_EXCLUDE="${FILTER_REGEX_EXCLUDE:-""}"
export FILTER_REGEX_EXCLUDE
# shellcheck disable=SC2034 # Variable is referenced in other scripts
RAW_FILE_ARRAY=() # Array of all files that were changed
# shellcheck disable=SC2034 # Variable is referenced in other scripts
TEST_CASE_FOLDER='test/linters' # Folder for test cases we should always ignore

# Set the log level
TF_LOG_LEVEL="info"
if [[ "${LOG_DEBUG}" == "true" ]]; then
  TF_LOG_LEVEL="debug"
fi
export TF_LOG_LEVEL
debug "TF_LOG_LEVEL: ${TF_LOG_LEVEL}"
TFLINT_LOG="${TF_LOG_LEVEL}"
export TFLINT_LOG
debug "TFLINT_LOG: ${TFLINT_LOG}"

# Load linter configuration and rules files
# shellcheck source=/dev/null
source /action/lib/globals/linterRules.sh

# Load languages array
# shellcheck source=/dev/null
source /action/lib/globals/languages.sh

Header() {
  if [[ "${SUPPRESS_POSSUM}" == "false" ]]; then
    info "$(/bin/bash /action/lib/functions/possum.sh)"
  fi

  info "---------------------------------------------"
  info "--- GitHub Actions Multi Language Linter ----"
  info " - Image Creation Date: ${BUILD_DATE}"
  info " - Image Revision: ${BUILD_REVISION}"
  info " - Image Version: ${BUILD_VERSION}"
  info "---------------------------------------------"
  info "---------------------------------------------"
  info "The Super-Linter source code can be found at:"
  info " - https://github.com/super-linter/super-linter"
  info "---------------------------------------------"

  if [[ ${VALIDATE_ALL_CODEBASE} != "false" ]]; then
    VALIDATE_ALL_CODEBASE="true"
    info "- Validating all files in code base..."
  else
    info "- Validating changed files in code base..."
  fi
}

ConfigureGitSafeDirectories() {
  debug "Configuring Git safe directories"
  declare -a git_safe_directories=("${GITHUB_WORKSPACE}" "${DEFAULT_SUPER_LINTER_WORKSPACE}" "${DEFAULT_WORKSPACE}")
  for safe_directory in "${git_safe_directories[@]}"; do
    debug "Set ${safe_directory} as a Git safe directory"
    if ! git config --global --add safe.directory "${safe_directory}"; then
      fatal "Cannot configure ${safe_directory} as a Git safe directory."
    fi
  done
}

GetGitHubVars() {
  info "--------------------------------------------"
  info "Gathering GitHub information..."

  local GITHUB_REPOSITORY_DEFAULT_BRANCH
  GITHUB_REPOSITORY_DEFAULT_BRANCH="master"

  if [[ ${RUN_LOCAL} != "false" ]]; then
    info "RUN_LOCAL has been set to: ${RUN_LOCAL}. Bypassing GitHub Actions variables..."

    if [ -z "${GITHUB_WORKSPACE:-}" ]; then
      GITHUB_WORKSPACE="${DEFAULT_WORKSPACE}"
    fi

    ValidateGitHubWorkspace "${GITHUB_WORKSPACE}"

    pushd "${GITHUB_WORKSPACE}" >/dev/null || exit 1

    if [[ "${USE_FIND_ALGORITHM}" == "false" ]]; then
      ConfigureGitSafeDirectories
      debug "Initializing GITHUB_SHA considering ${GITHUB_WORKSPACE}"
      if ! GITHUB_SHA=$(git -C "${GITHUB_WORKSPACE}" rev-parse HEAD); then
        fatal "Failed to initialize GITHUB_SHA. Output: ${GITHUB_SHA}"
      fi
      debug "GITHUB_SHA: ${GITHUB_SHA}"
    else
      debug "Skip the initalization of GITHUB_SHA because we don't need it"
    fi

    MULTI_STATUS="false"
    debug "Setting MULTI_STATUS to ${MULTI_STATUS} because we are not running on GitHub Actions"
  else
    ValidateGitHubWorkspace "${GITHUB_WORKSPACE}"

    # Ensure that Git can access the local repository
    ConfigureGitSafeDirectories

    if [ -z "${GITHUB_EVENT_PATH:-}" ]; then
      fatal "Failed to get GITHUB_EVENT_PATH: ${GITHUB_EVENT_PATH}]"
    else
      info "Successfully found GITHUB_EVENT_PATH: ${GITHUB_EVENT_PATH}]"
      debug "${GITHUB_EVENT_PATH} contents:\n$(cat "${GITHUB_EVENT_PATH}")"
    fi

    if [ -z "${GITHUB_SHA:-}" ]; then
      fatal "Failed to get GITHUB_SHA: ${GITHUB_SHA}"
    else
      info "Successfully found GITHUB_SHA: ${GITHUB_SHA}"
    fi

    if ! GIT_ROOT_COMMIT_SHA="$(git -C "${GITHUB_WORKSPACE}" rev-list --max-parents=0 "${GITHUB_SHA}")"; then
      fatal "Failed to get the root commit: ${GIT_ROOT_COMMIT_SHA}"
    else
      debug "Successfully found the root commit: ${GIT_ROOT_COMMIT_SHA}"
    fi
    export GIT_ROOT_COMMIT_SHA

    ##################################################
    # Need to pull the GitHub Vars from the env file #
    ##################################################

    GITHUB_ORG=$(jq -r '.repository.owner.login' <"${GITHUB_EVENT_PATH}")

    # Github sha on PR events is not the latest commit.
    # https://docs.github.com/en/actions/reference/events-that-trigger-workflows#pull_request
    if [ "$GITHUB_EVENT_NAME" == "pull_request" ]; then
      debug "This is a GitHub pull request. Updating the current GITHUB_SHA (${GITHUB_SHA}) to the pull request HEAD SHA"

      if ! GITHUB_SHA=$(jq -r .pull_request.head.sha <"$GITHUB_EVENT_PATH"); then
        fatal "Failed to update GITHUB_SHA for pull request event: ${GITHUB_SHA}"
      fi
      debug "Updated GITHUB_SHA: ${GITHUB_SHA}"
    elif [ "${GITHUB_EVENT_NAME}" == "push" ]; then
      debug "This is a GitHub push event."

      if [[ "${GITHUB_SHA}" == "${GIT_ROOT_COMMIT_SHA}" ]]; then
        debug "${GITHUB_SHA} is the initial commit. Skip initializing GITHUB_BEFORE_SHA because there no commit before the initial commit"
      else
        debug "${GITHUB_SHA} is not the initial commit"
        GITHUB_PUSH_COMMIT_COUNT=$(GetGithubPushEventCommitCount "$GITHUB_EVENT_PATH")
        if [ -z "${GITHUB_PUSH_COMMIT_COUNT}" ]; then
          fatal "Failed to get GITHUB_PUSH_COMMIT_COUNT"
        fi
        info "Successfully found GITHUB_PUSH_COMMIT_COUNT: ${GITHUB_PUSH_COMMIT_COUNT}"

        # Ref: https://docs.github.com/en/actions/learn-github-actions/contexts#github-context
        debug "Get the hash of the commit to start the diff from Git because the GitHub push event payload may not contain references to base_ref or previous commit."

        debug "Check if the commit is a merge commit by checking if it has more than one parent"
        local GIT_COMMIT_PARENTS_COUNT
        GIT_COMMIT_PARENTS_COUNT=$(git -C "${GITHUB_WORKSPACE}" rev-list --parents -n 1 "${GITHUB_SHA}" | wc -w)
        debug "Git commit parents count (GIT_COMMIT_PARENTS_COUNT): ${GIT_COMMIT_PARENTS_COUNT}"
        GIT_COMMIT_PARENTS_COUNT=$((GIT_COMMIT_PARENTS_COUNT - 1))
        debug "Subtract 1 from GIT_COMMIT_PARENTS_COUNT to get the actual number of merge parents because the count includes the commit itself. GIT_COMMIT_PARENTS_COUNT: ${GIT_COMMIT_PARENTS_COUNT}"

        # Ref: https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt
        local GIT_BEFORE_SHA_HEAD="HEAD"
        if [ ${GIT_COMMIT_PARENTS_COUNT} -gt 1 ]; then
          debug "${GITHUB_SHA} is a merge commit because it has more than one parent."
          GIT_BEFORE_SHA_HEAD="${GIT_BEFORE_SHA_HEAD}^2"
          debug "Add the suffix to GIT_BEFORE_SHA_HEAD to get the second parent of the merge commit: ${GIT_BEFORE_SHA_HEAD}"
          GITHUB_PUSH_COMMIT_COUNT=$((GITHUB_PUSH_COMMIT_COUNT - 1))
          debug "Remove one commit from GITHUB_PUSH_COMMIT_COUNT to account for the merge commit. GITHUB_PUSH_COMMIT_COUNT: ${GITHUB_PUSH_COMMIT_COUNT}"
        else
          debug "${GITHUB_SHA} is not a merge commit because it has a single parent. No need to add the parent identifier (^) to the revision indicator because it's implicitly set to ^1 when there's only one parent."
        fi

        GIT_BEFORE_SHA_HEAD="${GIT_BEFORE_SHA_HEAD}~${GITHUB_PUSH_COMMIT_COUNT}"
        debug "GIT_BEFORE_SHA_HEAD: ${GIT_BEFORE_SHA_HEAD}"

        # shellcheck disable=SC2086  # We checked that GITHUB_PUSH_COMMIT_COUNT is an integer
        if ! GITHUB_BEFORE_SHA=$(git -C "${GITHUB_WORKSPACE}" rev-parse ${GIT_BEFORE_SHA_HEAD}); then
          fatal "Failed to initialize GITHUB_BEFORE_SHA for a push event. Output: ${GITHUB_BEFORE_SHA}"
        fi

        ValidateGitBeforeShaReference
        info "Successfully found GITHUB_BEFORE_SHA: ${GITHUB_BEFORE_SHA}"
      fi
    fi

    ############################
    # Validate we have a value #
    ############################
    if [ -z "${GITHUB_ORG}" ]; then
      error "Failed to get [GITHUB_ORG]!"
      fatal "[${GITHUB_ORG}]"
    else
      info "Successfully found GITHUB_ORG: ${GITHUB_ORG}"
    fi

    #######################
    # Get the GitHub Repo #
    #######################
    GITHUB_REPO=$(jq -r '.repository.name' <"${GITHUB_EVENT_PATH}")

    ############################
    # Validate we have a value #
    ############################
    if [ -z "${GITHUB_REPO}" ]; then
      error "Failed to get [GITHUB_REPO]!"
      fatal "[${GITHUB_REPO}]"
    else
      info "Successfully found GITHUB_REPO: ${GITHUB_REPO}"
    fi

    GITHUB_REPOSITORY_DEFAULT_BRANCH=$(GetGithubRepositoryDefaultBranch "${GITHUB_EVENT_PATH}")
  fi

  if [ -z "${GITHUB_REPOSITORY_DEFAULT_BRANCH}" ]; then
    fatal "Failed to get GITHUB_REPOSITORY_DEFAULT_BRANCH"
  else
    debug "Successfully detected the default branch for this repository: ${GITHUB_REPOSITORY_DEFAULT_BRANCH}"
  fi

  DEFAULT_BRANCH="${DEFAULT_BRANCH:-${GITHUB_REPOSITORY_DEFAULT_BRANCH}}"

  if [[ "${DEFAULT_BRANCH}" != "${GITHUB_REPOSITORY_DEFAULT_BRANCH}" ]]; then
    debug "The default branch for this repository was set to ${GITHUB_REPOSITORY_DEFAULT_BRANCH}, but it was explicitly overridden using the DEFAULT_BRANCH variable, and set to: ${DEFAULT_BRANCH}"
  fi
  info "The default branch for this repository is set to: ${DEFAULT_BRANCH}"

  if [ "${MULTI_STATUS}" == "true" ]; then

    if [[ ${RUN_LOCAL} == "true" ]]; then
      # Safety check. This shouldn't occur because we forcefully set MULTI_STATUS=false above
      # when RUN_LOCAL=true
      fatal "Cannot enable status reports when running locally."
    fi

    if [ -z "${GITHUB_TOKEN:-}" ]; then
      fatal "Failed to get [GITHUB_TOKEN]. Terminating because status reports were explicitly enabled, but GITHUB_TOKEN was not provided."
    else
      info "Successfully found GITHUB_TOKEN."
    fi

    if [ -z "${GITHUB_REPOSITORY:-}" ]; then
      error "Failed to get [GITHUB_REPOSITORY]!"
      fatal "[${GITHUB_REPOSITORY}]"
    else
      info "Successfully found GITHUB_REPOSITORY: ${GITHUB_REPOSITORY}"
    fi

    if [ -z "${GITHUB_RUN_ID:-}" ]; then
      error "Failed to get [GITHUB_RUN_ID]!"
      fatal "[${GITHUB_RUN_ID}]"
    else
      info "Successfully found GITHUB_RUN_ID ${GITHUB_RUN_ID}"
    fi

    GITHUB_STATUS_URL="${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}/statuses/${GITHUB_SHA}"
    debug "GitHub Status URL: ${GITHUB_STATUS_URL}"

    GITHUB_STATUS_TARGET_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
    debug "GitHub Status target URL: ${GITHUB_STATUS_TARGET_URL}"
  else
    debug "Skip GITHUB_TOKEN, GITHUB_REPOSITORY, and GITHUB_RUN_ID validation because we don't need these variables for GitHub Actions status reports. MULTI_STATUS: ${MULTI_STATUS}"
  fi

  # We need this for parallel
  export GITHUB_WORKSPACE
}

CallStatusAPI() {
  LANGUAGE="${1}" # language that was validated
  STATUS="${2}"   # success | error
  SUCCESS_MSG='No errors were found in the linting process'
  FAIL_MSG='Errors were detected, please view logs'
  MESSAGE='' # Message to send to status API

  debug "Calling Multi-Status API for $LANGUAGE with status $STATUS"

  ######################################
  # Check the status to create message #
  ######################################
  if [ "${STATUS}" == "success" ]; then
    # Success
    MESSAGE="${SUCCESS_MSG}"
  else
    # Failure
    MESSAGE="${FAIL_MSG}"
  fi

  ##########################################################
  # Check to see if were enabled for multi Status mesaages #
  ##########################################################
  if [ "${MULTI_STATUS}" == "true" ] && [ -n "${GITHUB_TOKEN}" ] && [ -n "${GITHUB_REPOSITORY}" ]; then

    # make sure we honor DISABLE_ERRORS
    if [ "${DISABLE_ERRORS}" == "true" ]; then
      STATUS="success"
    fi

    ##############################################
    # Call the status API to create status check #
    ##############################################
    if ! SEND_STATUS_CMD=$(
      curl -f -s --show-error -X POST \
        --url "${GITHUB_STATUS_URL}" \
        -H 'accept: application/vnd.github.v3+json' \
        -H "authorization: Bearer ${GITHUB_TOKEN}" \
        -H 'content-type: application/json' \
        -d "{ \"state\": \"${STATUS}\",
        \"target_url\": \"${GITHUB_STATUS_TARGET_URL}\",
        \"description\": \"${MESSAGE}\", \"context\": \"--> Linted: ${LANGUAGE}\"
      }" 2>&1
    ); then
      info "Failed to call GitHub Status API: ${SEND_STATUS_CMD}"
    fi
  fi
}

Footer() {
  info "----------------------------------------------"
  info "----------------------------------------------"

  local ANY_LINTER_SUCCESS
  ANY_LINTER_SUCCESS="false"

  local SUPER_LINTER_EXIT_CODE
  SUPER_LINTER_EXIT_CODE=0

  if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
    debug "Saving Super-linter summary to ${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"
    WriteSummaryHeader "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"
  fi

  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    # This used to be the count of errors found for a given LANGUAGE, but since
    # after we switched to running linters against a batch of files, it may not
    # represent the actual number of files that didn't pass the validation,
    # but a number that's less than that because of how GNU parallel returns
    # exit codes.
    # Ref: https://www.gnu.org/software/parallel/parallel.html#exit-status
    ERROR_COUNTER_FILE_PATH="${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}/super-linter-parallel-command-exit-code-${LANGUAGE}"
    if [ ! -f "${ERROR_COUNTER_FILE_PATH}" ]; then
      debug "Error counter ${ERROR_COUNTER_FILE_PATH} doesn't exist"
    else
      ERROR_COUNTER=$(<"${ERROR_COUNTER_FILE_PATH}")
      debug "ERROR_COUNTER for ${LANGUAGE}: ${ERROR_COUNTER}"

      if [[ ${ERROR_COUNTER} -ne 0 ]]; then
        error "Errors found in ${LANGUAGE}"

        if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
          WriteSummaryLineFailure "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}" "${LANGUAGE}"
        fi

        # Print stdout and stderr in case the log level is higher than INFO
        # so users still get feedback. Print output as error so it gets emitted
        if [[ "${LOG_VERBOSE}" != "true" ]]; then
          local STDOUT_LINTER_FILE_PATH
          STDOUT_LINTER_FILE_PATH="${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}/super-linter-parallel-stdout-${LANGUAGE}"
          if [[ -e "${STDOUT_LINTER_FILE_PATH}" ]]; then
            error "Stdout contents for ${LANGUAGE}:\n------\n$(cat "${STDOUT_LINTER_FILE_PATH}")\n------"
          else
            debug "Stdout output file path for ${LANGUAGE} (${STDOUT_LINTER_FILE_PATH}) doesn't exist"
          fi

          local STDERR_LINTER_FILE_PATH
          STDERR_LINTER_FILE_PATH="${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}/super-linter-parallel-stderr-${LANGUAGE}"
          if [[ -e "${STDERR_LINTER_FILE_PATH}" ]]; then
            error "Stderr contents for ${LANGUAGE}:\n------\n$(cat "${STDERR_LINTER_FILE_PATH}")\n------"
          else
            debug "Stderr output file path for ${LANGUAGE} (${STDERR_LINTER_FILE_PATH}) doesn't exist"
          fi
        fi
        CallStatusAPI "${LANGUAGE}" "error"
        SUPER_LINTER_EXIT_CODE=1
        debug "Setting super-linter exit code to ${SUPER_LINTER_EXIT_CODE} because there were errors for ${LANGUAGE}"
      elif [[ ${ERROR_COUNTER} -eq 0 ]]; then
        notice "Successfully linted ${LANGUAGE}"
        if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
          WriteSummaryLineSuccess "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}" "${LANGUAGE}"
        fi
        CallStatusAPI "${LANGUAGE}" "success"
        ANY_LINTER_SUCCESS="true"
        debug "Set ANY_LINTER_SUCCESS to ${ANY_LINTER_SUCCESS} because ${LANGUAGE} reported a success"
      fi
    fi
  done

  if [[ "${ANY_LINTER_SUCCESS}" == "true" ]] && [[ ${SUPER_LINTER_EXIT_CODE} -ne 0 ]]; then
    SUPER_LINTER_EXIT_CODE=2
    debug "There was at least one linter that reported a success. Setting the super-linter exit code to: ${SUPER_LINTER_EXIT_CODE}"
  fi

  if [ "${DISABLE_ERRORS}" == "true" ]; then
    warn "The super-linter exit code is ${SUPER_LINTER_EXIT_CODE}. Forcibly setting it to 0 because DISABLE_ERRORS is set to: ${DISABLE_ERRORS}"
    SUPER_LINTER_EXIT_CODE=0
  fi

  if [[ ${SUPER_LINTER_EXIT_CODE} -eq 0 ]]; then
    notice "All files and directories linted successfully"
    if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
      WriteSummaryFooterSuccess "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"
    fi
  else
    error "Super-linter detected linting errors"
    if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
      WriteSummaryFooterFailure "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"
    fi
  fi

  if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
    if ! FormatSuperLinterSummaryFile "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"; then
      fatal "Error while formatting the Super-linter summary file."
    fi
    debug "Super-linter summary file (${SUPER_LINTER_SUMMARY_OUTPUT_PATH}) contents:\n$(cat "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}")"
  fi

  if [[ "${ENABLE_GITHUB_ACTIONS_STEP_SUMMARY}" == "true" ]]; then
    debug "Appending Super-linter summary to ${GITHUB_STEP_SUMMARY}"
    if ! cat "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}" >>"${GITHUB_STEP_SUMMARY}"; then
      fatal "Error while appending the content of ${SUPER_LINTER_SUMMARY_OUTPUT_PATH} to ${GITHUB_STEP_SUMMARY}"
    fi
  fi

  exit ${SUPER_LINTER_EXIT_CODE}
}

UpdateLoopsForImage() {
  ######################################################################
  # Need to clean the array lists of the linters removed for the image #
  ######################################################################
  if [[ "${IMAGE}" == "slim" ]]; then
    #############################################
    # Need to remove linters for the slim image #
    #############################################
    REMOVE_ARRAY=(
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

    # Remove from LANGUAGE_ARRAY
    debug "Removing Languages from LANGUAGE_ARRAY for slim image..."
    for REMOVE_LANGUAGE in "${REMOVE_ARRAY[@]}"; do
      for INDEX in "${!LANGUAGE_ARRAY[@]}"; do
        if [[ ${LANGUAGE_ARRAY[INDEX]} = "${REMOVE_LANGUAGE}" ]]; then
          debug "found item:[${REMOVE_LANGUAGE}], removing Language..."
          unset 'LANGUAGE_ARRAY[INDEX]'
        fi
      done
    done
  fi
}

# shellcheck disable=SC2317
cleanup() {
  local -ri EXIT_CODE=$?
  debug "Captured exit code: ${EXIT_CODE}"

  if [ -n "${GITHUB_WORKSPACE:-}" ]; then
    debug "Removing temporary files and directories"
    rm -rf \
      "${GITHUB_WORKSPACE}/.mypy_cache" \
      "${GITHUB_WORKSPACE}/logback.log"

    if [[ "${SUPER_LINTER_COPIED_R_LINTER_RULES_FILE:-}" == "true" ]]; then
      debug "Deleting ${R_RULES_FILE_PATH_IN_ROOT} because super-linter created it."
      rm -rf "${R_RULES_FILE_PATH_IN_ROOT}"
    fi

    # Define this variable here so we can rely on it as soon as possible
    local LOG_FILE_PATH="${GITHUB_WORKSPACE}/${LOG_FILE}"
    debug "LOG_FILE_PATH: ${LOG_FILE_PATH}"
    if [ "${CREATE_LOG_FILE}" = "true" ]; then
      if [[ "${REMOVE_ANSI_COLOR_CODES_FROM_OUTPUT}" == "true" ]] &&
        ! RemoveAnsiColorCodesFromFile "${LOG_TEMP}"; then
        fatal "Error while removing ANSI color codes from ${LOG_TEMP}"
      fi
      debug "Moving log file from ${LOG_TEMP} to ${LOG_FILE_PATH}"
      mv \
        --force \
        "${LOG_TEMP}" "${LOG_FILE_PATH}"
    else
      debug "Skip moving the log file from ${LOG_TEMP} to ${LOG_FILE_PATH}"
    fi

    if [ "${SAVE_SUPER_LINTER_OUTPUT}" = "true" ]; then
      debug "Super-linter output directory path is set to ${SUPER_LINTER_OUTPUT_DIRECTORY_PATH:-"not set"}"
      if [[ -n "${SUPER_LINTER_OUTPUT_DIRECTORY_PATH:-}" ]]; then
        debug "Super-linter output directory path is set to ${SUPER_LINTER_OUTPUT_DIRECTORY_PATH}"
        if [ -e "${SUPER_LINTER_OUTPUT_DIRECTORY_PATH}" ]; then
          debug "${SUPER_LINTER_OUTPUT_DIRECTORY_PATH} already exists. Deleting it before moving the new output directory there."
          rm -fr "${SUPER_LINTER_OUTPUT_DIRECTORY_PATH}"
        fi
        debug "Moving Super-linter output from ${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH} to ${SUPER_LINTER_OUTPUT_DIRECTORY_PATH}"
        mv "${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}" "${SUPER_LINTER_OUTPUT_DIRECTORY_PATH}"
      else
        debug "Skip moving the private Super-linter output directory (${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}) to the output directory because the Super-linter output destination directory path is not initialized yet"
      fi
    else
      debug "Skip moving the private Super-linter output directory (${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}) to the output directory (${SUPER_LINTER_OUTPUT_DIRECTORY_PATH:-"not initialized yet"})"
    fi

  else
    debug "GITHUB_WORKSPACE is not set. Skipping filesystem cleanup steps"
  fi

  exit "${EXIT_CODE}"
  trap - 0 1 2 3 6 14 15
}
trap 'cleanup' 0 1 2 3 6 14 15

##########
# Header #
##########
Header

################################################
# Need to update the loops for the image style #
################################################
UpdateLoopsForImage

# Print linter versions
info "This version of Super-linter includes the following tools:\n$(cat "${VERSION_FILE}")"

#######################
# Get GitHub Env Vars #
#######################
# Need to pull in all the GitHub variables
# needed to connect back and update checks
GetGitHubVars

# Ensure that Git safe directories are configured because we don't do this in
# all cases when initializing variables
ConfigureGitSafeDirectories

############################################
# Create SSH agent and add key if provided #
############################################
SetupSshAgent
SetupGithubComSshKeys

########################################################
# Initialize variables that depend on GitHub variables #
########################################################
TYPESCRIPT_STANDARD_TSCONFIG_FILE="${GITHUB_WORKSPACE}/${TYPESCRIPT_STANDARD_TSCONFIG_FILE:-"tsconfig.json"}"
debug "TYPESCRIPT_STANDARD_TSCONFIG_FILE: ${TYPESCRIPT_STANDARD_TSCONFIG_FILE}"

R_RULES_FILE_PATH_IN_ROOT="${GITHUB_WORKSPACE}/${R_FILE_NAME}"
debug "R_RULES_FILE_PATH_IN_ROOT: ${R_RULES_FILE_PATH_IN_ROOT}"

SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH="${GITHUB_WORKSPACE}/${SUPER_LINTER_OUTPUT_DIRECTORY_NAME}"
export SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH
debug "Super-linter main output directory path: ${SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH}"

SUPER_LINTER_OUTPUT_DIRECTORY_PATH="${SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH}/super-linter"
export SUPER_LINTER_OUTPUT_DIRECTORY_PATH
debug "Super-linter output directory path: ${SUPER_LINTER_OUTPUT_DIRECTORY_PATH}"

SUPER_LINTER_SUMMARY_OUTPUT_PATH="${SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH}/${SUPER_LINTER_SUMMARY_FILE_NAME:-"super-linter-summary.md"}"
export SUPER_LINTER_SUMMARY_OUTPUT_PATH
debug "Super-linter summary output path: ${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"

if [[ "${ENABLE_GITHUB_ACTIONS_STEP_SUMMARY}" == "true" ]] && [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "false" ]]; then
  debug "ENABLE_GITHUB_ACTIONS_STEP_SUMMARY is set to ${SAVE_SUPER_LINTER_SUMMARY}, but SAVE_SUPER_LINTER_SUMMARY is set to ${SAVE_SUPER_LINTER_SUMMARY}"
  SAVE_SUPER_LINTER_SUMMARY="true"
  debug "Set SAVE_SUPER_LINTER_SUMMARY to ${SAVE_SUPER_LINTER_SUMMARY} because we need to append its contents to ${GITHUB_STEP_SUMMARY} later"
fi

# Ensure that the main output directory and files exist because the user might not have created them
# before running Super-linter. These conditions list all the cases that require an output
# directory to be there.
if [[ "${SAVE_SUPER_LINTER_OUTPUT}" = "true" ]] ||
  [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]] ||
  [[ "${CREATE_LOG_FILE}" = "true" ]]; then
  debug "Ensure that ${SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH} exists"
  mkdir -p "${SUPER_LINTER_MAIN_OUTPUT_DIRECTORY_PATH}"
fi

if [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
  debug "Remove eventual ${SUPER_LINTER_SUMMARY_OUTPUT_PATH} leftover"
  rm -f "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"

  debug "Ensuring that ${SUPER_LINTER_SUMMARY_OUTPUT_PATH} exists."
  if ! touch "${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"; then
    fatal "Cannot create Super-linter summary file: ${SUPER_LINTER_SUMMARY_OUTPUT_PATH}"
  fi
fi

############################
# Validate the environment #
############################
info "--------------------------------------------"
info "Validating the configuration"
if ! ValidateFindMode; then
  fatal "Error while validating the configuration."
fi
if ! ValidateValidationVariables; then
  fatal "Error while validating the configuration of enabled linters"
fi
if ! ValidateAnsibleDirectory; then
  fatal "Error while validating the configuration of the Ansible directory"
fi

if [[ "${ENABLE_GITHUB_ACTIONS_STEP_SUMMARY}" == "true" ]] ||
  [[ "${SAVE_SUPER_LINTER_SUMMARY}" == "true" ]]; then
  if ! ValidateSuperLinterSummaryOutputPath; then
    fatal "Super-linter summary configuration failed validation"
  fi
else
  debug "Super-linter summary is disabled. No need to validate its configuration."
fi

if [[ "${USE_FIND_ALGORITHM}" == "false" ]] || [[ "${IGNORE_GITIGNORED_FILES}" == "true" ]]; then
  debug "Validate the local Git environment"
  ValidateLocalGitRepository

  # We need to validate the commit SHA reference and the default branch only when
  # using Git to get the list of files to lint
  if [[ "${USE_FIND_ALGORITHM}" == "false" ]]; then
    debug "Validate the Git SHA and branch references"
    ValidateGitShaReference
    ValidateDefaultGitBranch
  fi
else
  debug "Skipped the validation of the local Git environment because we don't depend on it."
fi

if ! ValidateCommitlintConfiguration "${GITHUB_WORKSPACE}" "${ENFORCE_COMMITLINT_CONFIGURATION_CHECK}"; then
  fatal "Error while validating commitlint configuration"
fi

ValidateDeprecatedVariables

# After checking if LOG_LEVEL is set to a deprecated value (see the ValidateDeprecatedVariables function),
# we can unset it so other programs that rely on this variable, such as Checkov and renovate-config-validator
# don't get confused.
unset LOG_LEVEL

#################################
# Get the linter rules location #
#################################
LinterRulesLocation

########################
# Get the linter rules #
########################
for LANGUAGE in "${LANGUAGE_ARRAY_FOR_LINTER_RULES[@]}"; do
  debug "Loading rules for ${LANGUAGE}..."
  eval "GetLinterRules ${LANGUAGE} ${DEFAULT_RULES_LOCATION}"
done

# Load rules for special cases
GetStandardRules "javascript"

#############################################################################
# Validate the environment that depends on linter rules variables being set #
#############################################################################

# We need the variables defined in linterCommandsOptions to initialize FIX_....
# variables.
# shellcheck source=/dev/null
source /action/lib/globals/linterCommandsOptions.sh
if ! ValidateCheckModeAndFixModeVariables; then
  fatal "Error while validating the configuration fix mode for linters that support that"
fi

#################################
# Check for SSL cert and update #
#################################
CheckSSLCert

###########################################
# Build the list of files for each linter #
###########################################
BuildFileList "${VALIDATE_ALL_CODEBASE}" "${TEST_CASE_RUN}"

#####################################
# Run additional Installs as needed #
#####################################
RunAdditionalInstalls

endGitHubActionsLogGroup "${SUPER_LINTER_INITIALIZATION_LOG_GROUP_TITLE}"

###############
# Run linters #
###############
declare PARALLEL_RESULTS_FILE_PATH
PARALLEL_RESULTS_FILE_PATH="${SUPER_LINTER_PRIVATE_OUTPUT_DIRECTORY_PATH}/super-linter-results.json"
debug "PARALLEL_RESULTS_FILE_PATH: ${PARALLEL_RESULTS_FILE_PATH}"

declare -i LINTING_MAX_PROCS
LINTING_MAX_PROCS=$(nproc)

CheckIfFixModeIsEnabled
if [[ "${FIX_MODE_ENABLED}" == "true" ]]; then
  # This slows down the fix process, but avoids that linters that work on the same
  # types of files try opening the same file at the same time
  LINTING_MAX_PROCS=1
  debug "Set LINTING_MAX_PROCS to ${LINTING_MAX_PROCS} to avoid that linters and formatters edit the same file at the same time."
fi

declare -a PARALLEL_COMMAND
PARALLEL_COMMAND=(parallel --will-cite --keep-order --max-procs "$((LINTING_MAX_PROCS))" --xargs --results "${PARALLEL_RESULTS_FILE_PATH}")

# Run one LANGUAGE per process. Each of these processes will run more processees in parellel if supported
PARALLEL_COMMAND+=(--max-lines 1)

if [ "${LOG_DEBUG}" == "true" ]; then
  debug "LOG_DEBUG is enabled. Enable verbose ouput for parallel"
  PARALLEL_COMMAND+=(--verbose)
fi

PARALLEL_COMMAND+=("LintCodebase" "{}" "\"${TEST_CASE_RUN}\"")
debug "PARALLEL_COMMAND: ${PARALLEL_COMMAND[*]}"

PARALLEL_COMMAND_OUTPUT=$(printf "%s\n" "${LANGUAGE_ARRAY[@]}" | "${PARALLEL_COMMAND[@]}" 2>&1)
PARALLEL_COMMAND_RETURN_CODE=$?
debug "PARALLEL_COMMAND_OUTPUT when running linters (exit code: ${PARALLEL_COMMAND_RETURN_CODE}):\n${PARALLEL_COMMAND_OUTPUT}"
debug "Parallel output file (${PARALLEL_RESULTS_FILE_PATH}) contents when running linters:\n$(cat "${PARALLEL_RESULTS_FILE_PATH}")"

RESULTS_OBJECT=
if ! RESULTS_OBJECT=$(jq --raw-output -n '[inputs]' "${PARALLEL_RESULTS_FILE_PATH}"); then
  fatal "Error loading results when building the file list: ${RESULTS_OBJECT}"
fi
debug "RESULTS_OBJECT when running linters:\n${RESULTS_OBJECT}"

# Get raw output so we can strip quotes from the data we load. Also, strip the final newline to avoid adding it two times
if ! STDOUT_LINTERS="$(jq --raw-output '.[] | select(.Stdout[:-1] | length > 0) | .Stdout[:-1]' <<<"${RESULTS_OBJECT}")"; then
  fatal "Error when loading stdout when running linters:\n${STDOUT_LINTERS}"
fi

if [ -n "${STDOUT_LINTERS}" ]; then
  info "Command output when running linters:\n------\n${STDOUT_LINTERS}\n------"
else
  debug "Stdout when running linters is empty"
fi

if ! STDERR_LINTERS="$(jq --raw-output '.[] | select(.Stderr[:-1] | length > 0) | .Stderr[:-1]' <<<"${RESULTS_OBJECT}")"; then
  fatal "Error when loading stderr for ${FILE_TYPE}:\n${STDERR_LINTERS}"
fi

if [ -n "${STDERR_LINTERS}" ]; then
  info "Stderr when running linters:\n------\n${STDERR_LINTERS}\n------"
else
  debug "Stderr when running linters is empty"
fi

if [[ ${PARALLEL_COMMAND_RETURN_CODE} -ne 0 ]]; then
  fatal "Error when running linters. Exit code: ${PARALLEL_COMMAND_RETURN_CODE}"
fi

##########
# Footer #
##########
Footer
