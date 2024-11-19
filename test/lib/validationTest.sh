#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# shellcheck source=/dev/null
source "test/testUtils.sh"

# shellcheck source=/dev/null
source "lib/functions/validation.sh"

IsUnsignedIntegerTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  local INPUT=1
  if ! IsUnsignedInteger ${INPUT}; then
    fatal "${FUNCTION_NAME} should have succeeded when checking ${INPUT}"
  fi

  INPUT="test"
  if IsUnsignedInteger "${INPUT}"; then
    fatal "${FUNCTION_NAME} should have failed when checking ${INPUT}"
  fi

  INPUT=-1
  if IsUnsignedInteger ${INPUT}; then
    fatal "${FUNCTION_NAME} should have failed when checking ${INPUT}"
  fi

  notice "${FUNCTION_NAME} PASS"
}

# In the current implementation, there is no return value to assert
function ValidateDeprecatedVariablesTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  ERROR_ON_MISSING_EXEC_BIT="true" \
    ValidateDeprecatedVariables
  EXPERIMENTAL_BATCH_WORKER="true" \
    ValidateDeprecatedVariables
  LOG_LEVEL="TRACE" \
    ValidateDeprecatedVariables
  LOG_LEVEL="VERBOSE" \
    ValidateDeprecatedVariables
  VALIDATE_JSCPD_ALL_CODEBASE="true" \
    ValidateDeprecatedVariables
  VALIDATE_KOTLIN_ANDROID="true" \
    ValidateDeprecatedVariables

  notice "${FUNCTION_NAME} PASS"
}

function ValidateGitHubUrlsTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  DEFAULT_GITHUB_DOMAIN="github.com"

  # shellcheck disable=SC2034
  GITHUB_DOMAIN=
  if ValidateGitHubUrls; then
    fatal "Empty GITHUB_DOMAIN should have failed validation"
  else
    info "Empty GITHUB_DOMAIN passed validation"
  fi

  # shellcheck disable=SC2034
  GITHUB_DOMAIN="github.example.com"
  if ! ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN} should have passed validation"
  else
    info "${GITHUB_DOMAIN} passed validation"
  fi
  unset GITHUB_DOMAIN

  # shellcheck disable=SC2034
  GITHUB_DOMAIN="${DEFAULT_GITHUB_DOMAIN}"
  if ! ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN} should have passed validation"
  else
    info "${GITHUB_DOMAIN} passed validation"
  fi
  unset GITHUB_DOMAIN

  GITHUB_DOMAIN="github.example.com"
  # shellcheck disable=SC2034
  GITHUB_CUSTOM_API_URL="github.custom.api.url"
  if ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_API_URL} should have failed validation"
  else
    info "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_API_URL} failed validation as expected"
  fi
  unset GITHUB_DOMAIN
  unset GITHUB_CUSTOM_API_URL

  # shellcheck disable=SC2034
  GITHUB_DOMAIN="github.example.com"
  GITHUB_CUSTOM_SERVER_URL="github.custom.server.url"
  if ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_SERVER_URL} should have failed validation"
  else
    info "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_SERVER_URL} failed validation as expected"
  fi
  unset GITHUB_DOMAIN
  unset GITHUB_CUSTOM_SERVER_URL

  # shellcheck disable=SC2034
  GITHUB_DOMAIN="${DEFAULT_GITHUB_DOMAIN}"
  GITHUB_CUSTOM_API_URL="github.custom.api.url"
  if ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_API_URL} should have failed validation"
  else
    info "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_API_URL} failed validation as expected"
  fi
  unset GITHUB_DOMAIN
  unset GITHUB_CUSTOM_API_URL

  # shellcheck disable=SC2034
  GITHUB_DOMAIN="${DEFAULT_GITHUB_DOMAIN}"
  GITHUB_CUSTOM_SERVER_URL="github.custom.server.url"
  if ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_SERVER_URL} should have failed validation"
  else
    info "${GITHUB_DOMAIN} and ${GITHUB_CUSTOM_SERVER_URL} failed validation as expected"
  fi
  unset GITHUB_DOMAIN
  unset GITHUB_CUSTOM_SERVER_URL

  # shellcheck disable=SC2034
  GITHUB_DOMAIN="${DEFAULT_GITHUB_DOMAIN}"
  GITHUB_CUSTOM_API_URL="github.custom.api.url"
  GITHUB_CUSTOM_SERVER_URL="github.custom.server.url"
  if ! ValidateGitHubUrls; then
    fatal "${GITHUB_DOMAIN}, ${GITHUB_CUSTOM_API_URL}, and ${GITHUB_CUSTOM_SERVER_URL} should have passed validation"
  else
    info "${GITHUB_DOMAIN}, ${GITHUB_CUSTOM_API_URL}, and ${GITHUB_CUSTOM_SERVER_URL} passed validation as expected"
  fi
  unset GITHUB_DOMAIN
  unset GITHUB_CUSTOM_API_URL
  unset GITHUB_CUSTOM_SERVER_URL

  notice "${FUNCTION_NAME} PASS"
}

function ValidateSuperLinterSummaryOutputPathTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  SUPER_LINTER_SUMMARY_OUTPUT_PATH="/non/existing/file"
  if ValidateSuperLinterSummaryOutputPath; then
    fatal "SUPER_LINTER_SUMMARY_OUTPUT_PATH=${SUPER_LINTER_SUMMARY_OUTPUT_PATH} should have failed validation when SUPER_LINTER_SUMMARY_OUTPUT_PATH is set to a non-existing file"
  else
    info "SUPER_LINTER_SUMMARY_OUTPUT_PATH=${SUPER_LINTER_SUMMARY_OUTPUT_PATH} failed validation as expected"
  fi
  unset SUPER_LINTER_SUMMARY_OUTPUT_PATH

  SUPER_LINTER_SUMMARY_OUTPUT_PATH="$(pwd)"
  if ValidateSuperLinterSummaryOutputPath; then
    fatal "SUPER_LINTER_SUMMARY_OUTPUT_PATH=${SUPER_LINTER_SUMMARY_OUTPUT_PATH} should have failed validation when SUPER_LINTER_SUMMARY_OUTPUT_PATH is set to a directory"
  else
    info "SUPER_LINTER_SUMMARY_OUTPUT_PATH=${SUPER_LINTER_SUMMARY_OUTPUT_PATH} failed validation as expected"
  fi
  unset SUPER_LINTER_SUMMARY_OUTPUT_PATH

  SUPER_LINTER_SUMMARY_OUTPUT_PATH="${0}"
  if ! ValidateSuperLinterSummaryOutputPath; then
    fatal "SUPER_LINTER_SUMMARY_OUTPUT_PATH=${SUPER_LINTER_SUMMARY_OUTPUT_PATH} should have passed validation when SUPER_LINTER_SUMMARY_OUTPUT_PATH is set to a file"
  else
    info "SUPER_LINTER_SUMMARY_OUTPUT_PATH=${SUPER_LINTER_SUMMARY_OUTPUT_PATH} passed validation as expected"
  fi
  unset SUPER_LINTER_SUMMARY_OUTPUT_PATH

  notice "${FUNCTION_NAME} PASS"
}

function ValidateFindModeTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  USE_FIND_ALGORITHM="true"
  VALIDATE_ALL_CODEBASE="false"
  if ValidateFindMode; then
    fatal "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} should have failed validation"
  else
    info "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} failed validation as expected"
  fi
  unset USE_FIND_ALGORITHM
  unset VALIDATE_ALL_CODEBASE

  USE_FIND_ALGORITHM="false"
  VALIDATE_ALL_CODEBASE="false"
  if ValidateFindMode; then
    info "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} passed validation as expected"
  else
    fatal "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} should have passed validation"
  fi
  unset USE_FIND_ALGORITHM
  unset VALIDATE_ALL_CODEBASE

  USE_FIND_ALGORITHM="false"
  VALIDATE_ALL_CODEBASE="true"
  if ValidateFindMode; then
    info "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} passed validation as expected"
  else
    fatal "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} should have passed validation"
  fi
  unset USE_FIND_ALGORITHM
  unset VALIDATE_ALL_CODEBASE

  USE_FIND_ALGORITHM="true"
  VALIDATE_ALL_CODEBASE="true"
  if ValidateFindMode; then
    info "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} passed validation as expected"
  else
    fatal "USE_FIND_ALGORITHM=${USE_FIND_ALGORITHM}, VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} should have passed validation"
  fi
  unset USE_FIND_ALGORITHM
  unset VALIDATE_ALL_CODEBASE

  notice "${FUNCTION_NAME} PASS"
}

function ValidateAnsibleDirectoryTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  GITHUB_WORKSPACE="/test-github-workspace"

  ValidateAnsibleDirectory
  EXPECTED_ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}/ansible"
  if [[ "${ANSIBLE_DIRECTORY:-}" != "${EXPECTED_ANSIBLE_DIRECTORY}" ]]; then
    fatal "ANSIBLE_DIRECTORY (${ANSIBLE_DIRECTORY}) is not equal to the expected value: ${EXPECTED_ANSIBLE_DIRECTORY}"
  fi

  ANSIBLE_DIRECTORY="."
  ValidateAnsibleDirectory
  EXPECTED_ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}"
  if [[ "${ANSIBLE_DIRECTORY:-}" != "${EXPECTED_ANSIBLE_DIRECTORY}" ]]; then
    fatal "ANSIBLE_DIRECTORY (${ANSIBLE_DIRECTORY}) is not equal to the expected value: ${EXPECTED_ANSIBLE_DIRECTORY}"
  fi

  INPUT_ANSIBLE_DIRECTORY="/custom-ansible-directory"
  ANSIBLE_DIRECTORY="${INPUT_ANSIBLE_DIRECTORY}"
  ValidateAnsibleDirectory
  EXPECTED_ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}${INPUT_ANSIBLE_DIRECTORY}"
  if [[ "${ANSIBLE_DIRECTORY:-}" != "${EXPECTED_ANSIBLE_DIRECTORY}" ]]; then
    fatal "ANSIBLE_DIRECTORY (${ANSIBLE_DIRECTORY}) is not equal to the expected value: ${EXPECTED_ANSIBLE_DIRECTORY}"
  fi

  INPUT_ANSIBLE_DIRECTORY="custom-ansible-directory"
  ANSIBLE_DIRECTORY="${INPUT_ANSIBLE_DIRECTORY}"
  ValidateAnsibleDirectory
  EXPECTED_ANSIBLE_DIRECTORY="${GITHUB_WORKSPACE}/${INPUT_ANSIBLE_DIRECTORY}"
  if [[ "${ANSIBLE_DIRECTORY:-}" != "${EXPECTED_ANSIBLE_DIRECTORY}" ]]; then
    fatal "ANSIBLE_DIRECTORY (${ANSIBLE_DIRECTORY}) is not equal to the expected value: ${EXPECTED_ANSIBLE_DIRECTORY}"
  fi

  unset GITHUB_WORKSPACE

  notice "${FUNCTION_NAME} PASS"
}

function ValidateValidationVariablesTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  LANGUAGE_ARRAY=('A' 'B')

  if ValidateValidationVariables; then
    info "Providing no VALIDATE_xxx variables passed validation as expected"
  else
    fatal "Providing no VALIDATE_xxx variables should have passed validation"
  fi

  VALIDATE_A="true"
  if ValidateValidationVariables; then
    info "VALIDATE_A=${VALIDATE_A} passed validation as expected"
  else
    fatal "VALIDATE_A=${VALIDATE_A} should have passed validation"
  fi
  unset VALIDATE_A

  # TODO: Refactor the ValidateBooleanVariable function to throw an error instead of a fatal
  # VALIDATE_A="blah"
  # if ! ValidateValidationVariables; then
  #   info "VALIDATE_A=${VALIDATE_A} failed validation as expected"
  # else
  #   fatal "VALIDATE_A=${VALIDATE_A} should have failed validation"
  # fi
  # unset VALIDATE_A

  VALIDATE_A="true"
  VALIDATE_B="true"
  if ValidateValidationVariables; then
    info "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} passed validation as expected"
  else
    fatal "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} should have passed validation"
  fi
  unset VALIDATE_A
  unset VALIDATE_B

  VALIDATE_A="false"
  VALIDATE_B="false"
  if ValidateValidationVariables; then
    info "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} passed validation as expected"
  else
    fatal "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} should have passed validation"
  fi
  unset VALIDATE_A
  unset VALIDATE_B

  VALIDATE_A="true"
  VALIDATE_B="false"
  if ! ValidateValidationVariables; then
    info "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} failed validation as expected"
  else
    fatal "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} should have failed validation"
  fi
  unset VALIDATE_A
  unset VALIDATE_B

  VALIDATE_A="false"
  VALIDATE_B="true"
  if ! ValidateValidationVariables; then
    info "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} failed validation as expected"
  else
    fatal "VALIDATE_A=${VALIDATE_A}, VALIDATE_B=${VALIDATE_B} should have failed validation"
  fi
  unset VALIDATE_A
  unset VALIDATE_B

  notice "${FUNCTION_NAME} PASS"
}

function ValidationVariablesExportTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  LANGUAGE_ARRAY=('A' 'B')

  ValidateValidationVariables

  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    local -n VALIDATE_LANGUAGE
    VALIDATE_LANGUAGE="VALIDATE_${LANGUAGE}"
    debug "VALIDATE_LANGUAGE (Language: ${LANGUAGE}) variable attributes: ${VALIDATE_LANGUAGE@a}"
    if [[ "${VALIDATE_LANGUAGE@a}" == *x* ]]; then
      info "VALIDATE_LANGUAGE for ${LANGUAGE} is exported as expected"
    else
      fatal "VALIDATE_LANGUAGE for ${LANGUAGE} should have been exported"
    fi
    unset -n VALIDATE_LANGUAGE
  done

  notice "${FUNCTION_NAME} PASS"
}

function ValidateCheckModeAndFixModeVariablesTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  LANGUAGE_ARRAY=('A' 'B' 'C' 'D')
  # shellcheck disable=SC2034
  A_FIX_MODE_OPTIONS=(--fixA)
  # shellcheck disable=SC2034
  A_CHECK_ONLY_MODE_OPTIONS=(--checkA)
  # shellcheck disable=SC2034
  B_FIX_MODE_OPTIONS=(--fixB)
  # shellcheck disable=SC2034
  C_CHECK_ONLY_MODE_OPTIONS=(--checkC)

  # shellcheck disable=SC2034
  VALIDATE_A="true"
  # shellcheck disable=SC2034
  VALIDATE_B="true"
  # shellcheck disable=SC2034
  VALIDATE_C="true"
  # shellcheck disable=SC2034
  FIX_B="true"

  if ! ValidateCheckModeAndFixModeVariables; then
    fatal "Error while validating fix mode variables"
  fi

  if [[ -v FIX_A ]]; then
    debug "FIX_A variable is defined as expected"
  else
    fatal "FIX_A variable should have been defined"
  fi

  EXPECTED_FIX_A="false"
  if [[ "${FIX_A}" == "${EXPECTED_FIX_A}" ]]; then
    debug "FIX_A variable has the expected value: ${FIX_A}"
  else
    fatal "FIX_A (${FIX_A}) doesn't match with the expected value: ${EXPECTED_FIX_A}"
  fi

  if [[ -v FIX_C ]]; then
    debug "FIX_C variable is defined as expected"
  else
    fatal "FIX_C variable should have been defined"
  fi

  EXPECTED_FIX_C="false"
  if [[ "${FIX_C}" == "${EXPECTED_FIX_C}" ]]; then
    debug "FIX_C variable has the expected value: ${FIX_C}"
  else
    fatal "FIX_C (${FIX_C}) doesn't match with the expected value: ${EXPECTED_FIX_C}"
  fi

  # No need to check if FIX_B is defined because we defined it earlier in this test function

  if [[ ! -v FIX_D ]]; then
    debug "FIX_D is not defined as expected"
  else
    fatal "FIX_D variable should have not been defined"
  fi

  debug "FIX_A variable attributes: ${FIX_A@a}"
  if [[ "${FIX_A@a}" == *x* ]]; then
    debug "FIX_A is exported as expected"
  else
    fatal "FIX_A should have been exported"
  fi

  debug "FIX_B variable attributes: ${FIX_B@a}"
  if [[ "${FIX_B@a}" == *x* ]]; then
    debug "FIX_B is exported as expected"
  else
    fatal "FIX_B should have been exported"
  fi

  debug "FIX_C variable attributes: ${FIX_C@a}"
  if [[ "${FIX_C@a}" == *x* ]]; then
    debug "FIX_C is exported as expected"
  else
    fatal "FIX_C should have been exported"
  fi

  unset FIX_A
  unset FIX_B
  unset FIX_C
  unset FIX_D
  unset VALIDATE_A
  unset VALIDATE_B
  unset VALIDATE_C

  # shellcheck disable=SC2034
  LANGUAGE_ARRAY=('E')
  # shellcheck disable=SC2034
  E_FIX_MODE_OPTIONS=(--fixA)
  FIX_E="true"
  VALIDATE_E="false"

  if ValidateCheckModeAndFixModeVariables; then
    fatal "FIX_E (${FIX_E}) and VALIDATE_E (${VALIDATE_E}) should have failed validation"
  else
    debug "FIX_E (${FIX_E}) and VALIDATE_E (${VALIDATE_E}) failed validation as expected"
  fi

  unset FIX_E
  unset VALIDATE_E

  # shellcheck disable=SC2034
  LANGUAGE_ARRAY=('F')
  FIX_F="true"

  if ValidateCheckModeAndFixModeVariables; then
    fatal "FIX_F (${FIX_F}) should have failed validation when it doesn't support fix mode or check only mode"
  else
    debug "FIX_F (${FIX_F}) failed validation as expected when it doesn't support fix mode or check only mode"
  fi

  unset FIX_F
  unset VALIDATE_F

  notice "${FUNCTION_NAME} PASS"
}

CheckIfFixModeIsEnabledTest() {
  # shellcheck disable=SC2034
  LANGUAGE_ARRAY=('A')

  FIX_MODE_ENABLED="false"
  FIX_A="true"
  CheckIfFixModeIsEnabled
  EXPECTED_FIX_MODE_ENABLED="true"
  if [[ "${FIX_MODE_ENABLED}" == "${EXPECTED_FIX_MODE_ENABLED}" ]]; then
    debug "FIX_MODE_ENABLED variable has the expected value: ${FIX_MODE_ENABLED}"
  else
    fatal "FIX_MODE_ENABLED (${FIX_MODE_ENABLED}) doesn't match with the expected value: ${EXPECTED_FIX_MODE_ENABLED}"
  fi

  FIX_MODE_ENABLED="false"
  FIX_A="false"
  CheckIfFixModeIsEnabled
  EXPECTED_FIX_MODE_ENABLED="false"
  if [[ "${FIX_MODE_ENABLED}" == "${EXPECTED_FIX_MODE_ENABLED}" ]]; then
    debug "FIX_MODE_ENABLED variable has the expected value: ${FIX_MODE_ENABLED}"
  else
    fatal "FIX_MODE_ENABLED (${FIX_MODE_ENABLED}) doesn't match with the expected value: ${EXPECTED_FIX_MODE_ENABLED}"
  fi

}

ValidateCommitlintConfigurationTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  GITHUB_WORKSPACE="$(mktemp -d)"
  initialize_git_repository "${GITHUB_WORKSPACE}"

  local ENFORCE_COMMITLINT_CONFIGURATION_CHECK="false"

  VALIDATE_GIT_COMMITLINT="false"
  if ! ValidateCommitlintConfiguration "${GITHUB_WORKSPACE}" "${ENFORCE_COMMITLINT_CONFIGURATION_CHECK}"; then
    fatal "VALIDATE_GIT_COMMITLINT: ${VALIDATE_GIT_COMMITLINT} should have passed validation"
  else
    debug "VALIDATE_GIT_COMMITLINT: ${VALIDATE_GIT_COMMITLINT} passed validation as expected"
  fi

  VALIDATE_GIT_COMMITLINT="true"
  if ! ValidateCommitlintConfiguration "${GITHUB_WORKSPACE}" "${ENFORCE_COMMITLINT_CONFIGURATION_CHECK}"; then
    fatal "VALIDATE_GIT_COMMITLINT: ${VALIDATE_GIT_COMMITLINT}, ENFORCE_COMMITLINT_CONFIGURATION_CHECK: ${ENFORCE_COMMITLINT_CONFIGURATION_CHECK} should have passed validation"
  else
    debug "VALIDATE_GIT_COMMITLINT: ${VALIDATE_GIT_COMMITLINT}, ENFORCE_COMMITLINT_CONFIGURATION_CHECK: ${ENFORCE_COMMITLINT_CONFIGURATION_CHECK} passed validation as expected"
  fi
  if [[ "${VALIDATE_GIT_COMMITLINT}" == "true" ]]; then
    fatal "VALIDATE_GIT_COMMITLINT should have been false"
  else
    debug "VALIDATE_GIT_COMMITLINT is ${VALIDATE_GIT_COMMITLINT} as expected"
  fi

  VALIDATE_GIT_COMMITLINT="true"
  ENFORCE_COMMITLINT_CONFIGURATION_CHECK="true"
  if ValidateCommitlintConfiguration "${GITHUB_WORKSPACE}" "${ENFORCE_COMMITLINT_CONFIGURATION_CHECK}"; then
    fatal "VALIDATE_GIT_COMMITLINT: ${VALIDATE_GIT_COMMITLINT}, ENFORCE_COMMITLINT_CONFIGURATION_CHECK: ${ENFORCE_COMMITLINT_CONFIGURATION_CHECK} should have failed validation"
  else
    debug "VALIDATE_GIT_COMMITLINT: ${VALIDATE_GIT_COMMITLINT}, ENFORCE_COMMITLINT_CONFIGURATION_CHECK: ${ENFORCE_COMMITLINT_CONFIGURATION_CHECK} failed validation as expected"
  fi

  notice "${FUNCTION_NAME} PASS"
}

IsUnsignedIntegerTest
ValidateDeprecatedVariablesTest
ValidateGitHubUrlsTest
ValidateSuperLinterSummaryOutputPathTest
ValidateFindModeTest
ValidateAnsibleDirectoryTest
ValidateValidationVariablesTest
ValidationVariablesExportTest
ValidateCheckModeAndFixModeVariablesTest
CheckIfFixModeIsEnabledTest
ValidateCommitlintConfigurationTest
