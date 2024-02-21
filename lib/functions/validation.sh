#!/usr/bin/env bash

function ValidateBooleanConfigurationVariables() {
  ValidateBooleanVariable "ACTIONS_RUNNER_DEBUG" "${ACTIONS_RUNNER_DEBUG}"
  ValidateBooleanVariable "CREATE_LOG_FILE" "${CREATE_LOG_FILE}"
  ValidateBooleanVariable "DISABLE_ERRORS" "${DISABLE_ERRORS}"
  ValidateBooleanVariable "ENABLE_GITHUB_ACTIONS_GROUP_TITLE" "${ENABLE_GITHUB_ACTIONS_GROUP_TITLE}"
  ValidateBooleanVariable "IGNORE_GENERATED_FILES" "${IGNORE_GENERATED_FILES}"
  ValidateBooleanVariable "IGNORE_GITIGNORED_FILES" "${IGNORE_GITIGNORED_FILES}"
  ValidateBooleanVariable "LOG_DEBUG" "${LOG_DEBUG}"
  ValidateBooleanVariable "LOG_ERROR" "${LOG_ERROR}"
  ValidateBooleanVariable "LOG_NOTICE" "${LOG_NOTICE}"
  ValidateBooleanVariable "LOG_VERBOSE" "${LOG_VERBOSE}"
  ValidateBooleanVariable "LOG_WARN" "${LOG_WARN}"
  ValidateBooleanVariable "MULTI_STATUS" "${MULTI_STATUS}"
  ValidateBooleanVariable "RUN_LOCAL" "${RUN_LOCAL}"
  ValidateBooleanVariable "SSH_INSECURE_NO_VERIFY_GITHUB_KEY" "${SSH_INSECURE_NO_VERIFY_GITHUB_KEY}"
  ValidateBooleanVariable "SSH_SETUP_GITHUB" "${SSH_SETUP_GITHUB}"
  ValidateBooleanVariable "SUPPRESS_FILE_TYPE_WARN" "${SUPPRESS_FILE_TYPE_WARN}"
  ValidateBooleanVariable "SUPPRESS_POSSUM" "${SUPPRESS_POSSUM}"
  ValidateBooleanVariable "TEST_CASE_RUN" "${TEST_CASE_RUN}"
  ValidateBooleanVariable "USE_FIND_ALGORITHM" "${USE_FIND_ALGORITHM}"
  ValidateBooleanVariable "VALIDATE_ALL_CODEBASE" "${VALIDATE_ALL_CODEBASE}"
  ValidateBooleanVariable "YAML_ERROR_ON_WARNING" "${YAML_ERROR_ON_WARNING}"
}

function ValidateGitHubWorkspace() {
  local GITHUB_WORKSPACE
  GITHUB_WORKSPACE="${1}"
  if [ -z "${GITHUB_WORKSPACE}" ]; then
    fatal "Failed to get GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}"
  fi

  if [ ! -d "${GITHUB_WORKSPACE}" ]; then
    fatal "The workspace (${GITHUB_WORKSPACE}) is not a directory!"
  fi
  info "Successfully validated GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}"
}

function GetValidationInfo() {
  info "--------------------------------------------"
  info "Validating the configuration"

  if [[ "${USE_FIND_ALGORITHM}" == "true" ]] && [[ "${VALIDATE_ALL_CODEBASE}" == "false" ]]; then
    fatal "Setting USE_FIND_ALGORITHM to true and VALIDATE_ALL_CODEBASE to false is not supported because super-linter relies on Git to validate changed files."
  fi

  ################################################
  # Determine if any linters were explicitly set #
  ################################################
  ANY_SET="false"
  ANY_TRUE="false"
  ANY_FALSE="false"

  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    local VALIDATE_LANGUAGE
    VALIDATE_LANGUAGE="VALIDATE_${LANGUAGE}"
    debug "Set VALIDATE_LANGUAGE while validating the configuration: ${VALIDATE_LANGUAGE}"
    if [ -n "${!VALIDATE_LANGUAGE:-}" ]; then
      # Validate if user provided a string representing a valid boolean
      ValidateBooleanVariable "${VALIDATE_LANGUAGE}" "${!VALIDATE_LANGUAGE}"
      # It was set, need to set flag
      ANY_SET="true"
      if [ "${!VALIDATE_LANGUAGE}" == "true" ]; then
        ANY_TRUE="true"
      elif [ "${!VALIDATE_LANGUAGE}" == "false" ]; then
        ANY_FALSE="true"
      fi
    else
      debug "Configuration didn't provide a custom value for ${VALIDATE_LANGUAGE}"
    fi
  done

  if [ $ANY_TRUE == "true" ] && [ $ANY_FALSE == "true" ]; then
    fatal "Behavior not supported, please either only include (VALIDATE=true) or exclude (VALIDATE=false) linters, but not both"
  fi

  #########################################################
  # Validate if we should check/omit individual languages #
  #########################################################
  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    local VALIDATE_LANGUAGE
    VALIDATE_LANGUAGE="VALIDATE_${LANGUAGE}"
    if [[ ${ANY_SET} == "true" ]]; then
      if [ -z "${!VALIDATE_LANGUAGE:-}" ]; then
        # Flag was not set, default to:
        # if ANY_TRUE then set to false
        # if ANY_FALSE then set to true
        eval "${VALIDATE_LANGUAGE}='$ANY_FALSE'"
      fi
    else
      # No linter flags were set - default all to true
      eval "${VALIDATE_LANGUAGE}='true'"
    fi
    eval "export ${VALIDATE_LANGUAGE}"
  done

  #######################################
  # Print which linters we are enabling #
  #######################################
  # Loop through all languages
  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    local VALIDATE_LANGUAGE
    VALIDATE_LANGUAGE="VALIDATE_${LANGUAGE}"
    if [[ ${!VALIDATE_LANGUAGE} == "true" ]]; then
      debug "- Validating [${LANGUAGE}] files in code base..."
    else
      debug "- Excluding [$LANGUAGE] files in code base..."
    fi
  done

  ##############################
  # Validate Ansible Directory #
  ##############################
  if [ -z "${ANSIBLE_DIRECTORY:-}" ]; then
    ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}/ansible"
    debug "Set ANSIBLE_DIRECTORY to the default: ${ANSIBLE_DIRECTORY}"
  else
    debug "ANSIBLE_DIRECTORY before considering corner cases: ${ANSIBLE_DIRECTORY}"
    # Check if first char is '/'
    if [[ ${ANSIBLE_DIRECTORY:0:1} == "/" ]]; then
      # Remove first char
      ANSIBLE_DIRECTORY="${ANSIBLE_DIRECTORY:1}"
    fi

    if [ -z "${ANSIBLE_DIRECTORY}" ] || [[ ${ANSIBLE_DIRECTORY} == "." ]]; then
      # Catches the case where ANSIBLE_DIRECTORY="/" or ANSIBLE_DIRECTORY="."
      TEMP_ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}"
    else
      # Need to give it full path
      TEMP_ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}/${ANSIBLE_DIRECTORY}"
    fi

    # Set the value
    ANSIBLE_DIRECTORY="${TEMP_ANSIBLE_DIRECTORY}"
    debug "Setting Ansible directory to: ${ANSIBLE_DIRECTORY}"
  fi
}

function CheckIfGitBranchExists() {
  local BRANCH_NAME="${1}"
  debug "Check if the ${BRANCH_NAME} branch exists in ${GITHUB_WORKSPACE}"
  if ! git -C "${GITHUB_WORKSPACE}" rev-parse --quiet --verify "${BRANCH_NAME}"; then
    info "The ${BRANCH_NAME} branch doesn't exist in ${GITHUB_WORKSPACE}"
    return 1
  else
    debug "The ${BRANCH_NAME} branch exists in ${GITHUB_WORKSPACE}"
    return 0
  fi
}

function ValidateBooleanVariable() {
  local VAR_NAME
  VAR_NAME="${1}"

  local VAR_VALUE
  VAR_VALUE="${2}"

  if [[ "${VAR_VALUE}" != "true" ]] && [[ "${VAR_VALUE}" != "false" ]]; then
    fatal "Set ${VAR_NAME} to either true or false. It was set to: ${VAR_VALUE}"
  else
    debug "${VAR_NAME} has a valid boolean string value: ${VAR_VALUE}"
  fi
}
export -f ValidateBooleanVariable

function ValidateLocalGitRepository() {
  debug "Check if ${GITHUB_WORKSPACE} is a Git repository"
  if ! git -C "${GITHUB_WORKSPACE}" rev-parse --git-dir; then
    fatal "${GITHUB_WORKSPACE} is not a Git repository."
  else
    debug "${GITHUB_WORKSPACE} is a Git repository"
  fi

  debug "Git branches: $(git -C "${GITHUB_WORKSPACE}" branch -a)"
}

function CheckIfGitRefExists() {
  local GIT_REF=${1}
  if git -C "${GITHUB_WORKSPACE}" cat-file -e "${GIT_REF}"; then
    return 0
  else
    return 1
  fi
}

function IsUnsignedInteger() {
  case ${1} in
  '' | *[!0-9]*)
    return 1
    ;;
  *)
    return 0
    ;;
  esac
}

function ValidateGitShaReference() {
  debug "Git HEAD: $(git -C "${GITHUB_WORKSPACE}" show HEAD --stat)"

  debug "Validate that the GITHUB_SHA reference (${GITHUB_SHA}) exists in this Git repository."
  if ! CheckIfGitRefExists "${GITHUB_SHA}"; then
    fatal "The GITHUB_SHA reference (${GITHUB_SHA}) doesn't exist in this Git repository"
  else
    debug "The GITHUB_SHA reference (${GITHUB_SHA}) exists in this repository"
  fi
}

function ValidateGitBeforeShaReference() {
  debug "Validating GITHUB_BEFORE_SHA: ${GITHUB_BEFORE_SHA}"
  if [ -z "${GITHUB_BEFORE_SHA}" ] ||
    [ "${GITHUB_BEFORE_SHA}" == "null" ] ||
    [ "${GITHUB_BEFORE_SHA}" == "0000000000000000000000000000000000000000" ]; then
    fatal "Failed to get GITHUB_BEFORE_SHA: [${GITHUB_BEFORE_SHA}]"
  fi

  debug "Validate that the GITHUB_BEFORE_SHA reference (${GITHUB_BEFORE_SHA}) exists in this Git repository."
  if ! CheckIfGitRefExists "${GITHUB_BEFORE_SHA}"; then
    fatal "The GITHUB_BEFORE_SHA reference (${GITHUB_BEFORE_SHA}) doesn't exist in this Git repository"
  else
    debug "The GITHUB_BEFORE_SHA reference (${GITHUB_BEFORE_SHA}) exists in this repository"
  fi
}

function ValidateDefaultGitBranch() {
  debug "Check if the default branch (${DEFAULT_BRANCH}) exists"
  if ! CheckIfGitBranchExists "${DEFAULT_BRANCH}"; then
    REMOTE_DEFAULT_BRANCH="origin/${DEFAULT_BRANCH}"
    debug "The default branch (${DEFAULT_BRANCH}) doesn't exist in this Git repository. Trying with ${REMOTE_DEFAULT_BRANCH}"
    if ! CheckIfGitBranchExists "${REMOTE_DEFAULT_BRANCH}"; then
      fatal "Neither ${DEFAULT_BRANCH}, nor ${REMOTE_DEFAULT_BRANCH} exist in ${GITHUB_WORKSPACE}"
    else
      info "${DEFAULT_BRANCH} doesn't exist, however ${REMOTE_DEFAULT_BRANCH} exists. Setting DEFAULT_BRANCH to: ${REMOTE_DEFAULT_BRANCH}"
      DEFAULT_BRANCH="${REMOTE_DEFAULT_BRANCH}"
      debug "Updated DEFAULT_BRANCH: ${DEFAULT_BRANCH}"
    fi
  else
    debug "The default branch (${DEFAULT_BRANCH}) exists in this repository"
  fi
}

function CheckovConfigurationFileContainsDirectoryOption() {
  local CHECKOV_LINTER_RULES_PATH="${1}"
  local CONFIGURATION_OPTION_KEY="directory:"
  debug "Checking if ${CHECKOV_LINTER_RULES_PATH} contains a '${CONFIGURATION_OPTION_KEY}' configuration option"

  if [ ! -e "${CHECKOV_LINTER_RULES_PATH}" ]; then
    fatal "${CHECKOV_LINTER_RULES_PATH} doesn't exist. Cannot check if it contains a '${CONFIGURATION_OPTION_KEY}' configuration option"
  fi

  if grep -q "${CONFIGURATION_OPTION_KEY}" "${CHECKOV_LINTER_RULES_PATH}"; then
    debug "${CHECKOV_LINTER_RULES_PATH} contains a '${CONFIGURATION_OPTION_KEY}' statement"
    return 0
  else
    debug "${CHECKOV_LINTER_RULES_PATH} doesn't contain a '${CONFIGURATION_OPTION_KEY}' statement"
    return 1
  fi
}
export -f CheckovConfigurationFileContainsDirectoryOption

function WarnIfVariableIsSet() {
  local INPUT_VARIABLE="${1}"
  shift
  local INPUT_VARIABLE_NAME="${1}"

  if [ -n "${INPUT_VARIABLE:-}" ]; then
    warn "${INPUT_VARIABLE_NAME} environment variable is set, it's deprecated, and super-linter will ignore it. Remove it from your configuration. This warning may turn in a fatal error in the future. For more information, see the upgrade guide: https://github.com/super-linter/super-linter/blob/main/docs/upgrade-guide.md"
  fi
}

function WarnIfDeprecatedValueForConfigurationVariableIsSet() {
  local INPUT_VARIABLE_VALUE
  INPUT_VARIABLE_VALUE="${1}"
  shift
  local DEPRECATED_VARIABLE_VALUE
  DEPRECATED_VARIABLE_VALUE="${1}"
  shift
  local INPUT_VARIABLE_NAME
  INPUT_VARIABLE_NAME="${1}"
  shift
  local VALUE_TO_UPDATE_TO
  VALUE_TO_UPDATE_TO="${1}"

  if [[ "${INPUT_VARIABLE_VALUE}" == "${DEPRECATED_VARIABLE_VALUE}" ]]; then
    warn "${INPUT_VARIABLE_NAME} is set to a deprecated value: ${DEPRECATED_VARIABLE_VALUE}. Set it to ${VALUE_TO_UPDATE_TO} instead. Falling back to ${VALUE_TO_UPDATE_TO}. This warning may turn in a fatal error in the future."
  fi
}

function ValidateDeprecatedVariables() {

  # The following variables have been deprecated in v6
  WarnIfVariableIsSet "${ERROR_ON_MISSING_EXEC_BIT:-}" "ERROR_ON_MISSING_EXEC_BIT"
  WarnIfVariableIsSet "${EXPERIMENTAL_BATCH_WORKER:-}" "EXPERIMENTAL_BATCH_WORKER"
  WarnIfVariableIsSet "${VALIDATE_JSCPD_ALL_CODEBASE:-}" "VALIDATE_JSCPD_ALL_CODEBASE"
  WarnIfVariableIsSet "${VALIDATE_KOTLIN_ANDROID:-}" "VALIDATE_KOTLIN_ANDROID"

  # The following values have been deprecated in v6.1.0
  WarnIfDeprecatedValueForConfigurationVariableIsSet "${LOG_LEVEL}" "TRACE" "LOG_LEVEL" "DEBUG"
  WarnIfDeprecatedValueForConfigurationVariableIsSet "${LOG_LEVEL}" "VERBOSE" "LOG_LEVEL" "INFO"
}
