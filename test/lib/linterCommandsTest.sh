#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# shellcheck source=/dev/null
source "test/testUtils.sh"

# linterCommands.sh needs these

# shellcheck source=/dev/null
source "lib/globals/languages.sh"
# shellcheck source=/dev/null
source "lib/globals/linterRules.sh"
# shellcheck source=/dev/null
source "lib/functions/linterRules.sh"
# shellcheck source=/dev/null
source "lib/functions/validation.sh"

# Initialize the environment
# shellcheck disable=SC2034
BASH_EXEC_IGNORE_LIBRARIES="false"
# shellcheck disable=SC2034
GITHUB_WORKSPACE="$(pwd)"
# shellcheck disable=SC2034
IGNORE_GITIGNORED_FILES="false"
# shellcheck disable=SC2034
TYPESCRIPT_STANDARD_TSCONFIG_FILE=".github/linters/tsconfig.json"
# shellcheck disable=SC2034
YAML_ERROR_ON_WARNING="false"
for LANGUAGE in "${LANGUAGE_ARRAY_FOR_LINTER_RULES[@]}"; do
  GetLinterRules "${LANGUAGE}" "TEMPLATES"
done
ValidateValidationVariables

# Now we can load linter command options because they have
# dependencies on linter rules
# shellcheck source=/dev/null
source /action/lib/globals/linterCommandsOptions.sh

# The slim image might not have this variable defined
if [[ ! -v ARM_TTK_PSD1 ]]; then
  ARM_TTK_PSD1="/usr/lib/microsoft/arm-ttk/arm-ttk.psd1"
fi

# Source the file so we can load commands to compare them without redefining
# each command. We're not interested in the actual values of those commands, but
# only in how we eventually modify them.

# shellcheck source=/dev/null
source "lib/functions/linterCommands.sh"

# Initialize the variables we're going to use to verify tests before running tests
# because some tests modify LINTER_COMMANDS_xxx variables
BASE_LINTER_COMMANDS_ARRAY_ANSIBLE=("${LINTER_COMMANDS_ARRAY_ANSIBLE[@]}")
BASE_LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS=("${LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS[@]}")
BASE_LINTER_COMMANDS_ARRAY_GIT_COMMITLINT=("${LINTER_COMMANDS_ARRAY_GIT_COMMITLINT[@]}")
BASE_LINTER_COMMANDS_ARRAY_GITLEAKS=("${LINTER_COMMANDS_ARRAY_GITLEAKS[@]}")
BASE_LINTER_COMMANDS_ARRAY_GO_MODULES=("${LINTER_COMMANDS_ARRAY_GO_MODULES[@]}")
BASE_LINTER_COMMANDS_ARRAY_JSCPD=("${LINTER_COMMANDS_ARRAY_JSCPD[@]}")
BASE_LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM=("${LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM[@]}")
BASE_LINTER_COMMANDS_ARRAY_PERL=("${LINTER_COMMANDS_ARRAY_PERL[@]}")
BASE_LINTER_COMMANDS_ARRAY_RUST_CLIPPY=("${LINTER_COMMANDS_ARRAY_RUST_CLIPPY[@]}")

function LinterCommandPresenceTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    local LINTER_COMMAND_ARRAY_VARIABLE_NAME="LINTER_COMMANDS_ARRAY_${LANGUAGE}"
    debug "Check if ${LINTER_COMMAND_ARRAY_VARIABLE_NAME} has at least one element"
    local -n LINTER_COMMAND_ARRAY="${LINTER_COMMAND_ARRAY_VARIABLE_NAME}"
    if [ ${#LINTER_COMMAND_ARRAY[@]} -eq 0 ]; then
      fatal "LINTER_COMMAND_ARRAY for ${LANGUAGE} is empty."
    else
      debug "LINTER_COMMAND_ARRAY for ${LANGUAGE} has ${#LINTER_COMMAND_ARRAY[@]} elements: ${LINTER_COMMAND_ARRAY[*]}"
    fi
    unset -n LINTER_COMMAND_ARRAY
  done

  notice "${FUNCTION_NAME} PASS"
}

function IgnoreGitIgnoredFilesJscpdCommandTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  IGNORE_GITIGNORED_FILES="true"

  # Source the file again so it accounts for modifications
  # shellcheck source=/dev/null
  source "lib/functions/linterCommands.sh"

  EXPECTED_COMMAND=("${BASE_LINTER_COMMANDS_ARRAY_JSCPD[@]}" "${JSCPD_GITIGNORE_OPTION}")

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_JSCPD" "EXPECTED_COMMAND"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  notice "${FUNCTION_NAME} PASS"
}

function JscpdCommandTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  IGNORE_GITIGNORED_FILES="false"

  # Source the file again so it accounts for modifications
  # shellcheck source=/dev/null
  source "lib/functions/linterCommands.sh"

  # shellcheck disable=SC2034
  EXPECTED_COMMAND=("${BASE_LINTER_COMMANDS_ARRAY_JSCPD[@]}")

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_JSCPD" "EXPECTED_COMMAND"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  notice "${FUNCTION_NAME} PASS"
}

EnableCommitlintStrictModeCommandTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  ENABLE_COMMITLINT_STRICT_MODE="true"

  # Source the file again so it accounts for modifications
  # shellcheck source=/dev/null
  source "lib/functions/linterCommands.sh"

  EXPECTED_COMMAND=("${BASE_LINTER_COMMANDS_ARRAY_GIT_COMMITLINT[@]}" "${COMMITLINT_STRICT_MODE_OPTIONS[@]}")

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_GIT_COMMITLINT" "EXPECTED_COMMAND"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  notice "${FUNCTION_NAME} PASS"
}

function GitleaksCommandTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  EXPECTED_COMMAND=("${BASE_LINTER_COMMANDS_ARRAY_GITLEAKS[@]}")

  if [[ "${EXPECTED_GITLEAKS_LOG_LEVEL:-}" ]]; then
    # The gitleaks command ends with an option to specify the path
    # to the file to check, so we need to append the log option before that.
    local GITLEAKS_FILE_PATH_OPTION="${EXPECTED_COMMAND[-1]}"

    # Remove the file path option so we can append the log option
    unset 'EXPECTED_COMMAND[-1]'
    # shellcheck disable=SC2034
    GITLEAKS_LOG_LEVEL="${EXPECTED_GITLEAKS_LOG_LEVEL}"
    EXPECTED_COMMAND+=("${GITLEAKS_LOG_LEVEL_OPTIONS[@]}" "${EXPECTED_GITLEAKS_LOG_LEVEL}")

    # Add the file path option back
    EXPECTED_COMMAND+=("${GITLEAKS_FILE_PATH_OPTION}")
  fi

  # Source the file again so it accounts for modifications
  # shellcheck source=/dev/null
  source "lib/functions/linterCommands.sh"

  if [[ ! -v GITLEAKS_LOG_LEVEL_OPTIONS ]]; then
    fatal "GITLEAKS_LOG_LEVEL_OPTIONS is not defined"
  fi

  if [[ "${#GITLEAKS_LOG_LEVEL_OPTIONS[@]}" -eq 0 ]]; then
    fatal "GITLEAKS_LOG_LEVEL_OPTIONS is empty"
  fi

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_GITLEAKS" "EXPECTED_COMMAND"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  notice "${FUNCTION_NAME} PASS"
}

function GitleaksCommandCustomLogLevelTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  EXPECTED_GITLEAKS_LOG_LEVEL="debug"
  GitleaksCommandTest

  notice "${FUNCTION_NAME} PASS"
}

function InitInputConsumeCommandsTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  EXPECTED_LINTER_COMMANDS_ARRAY_ANSIBLE=("${BASE_LINTER_COMMANDS_ARRAY_ANSIBLE[@]}" "${INPUT_CONSUME_COMMAND[@]}")
  # shellcheck disable=SC2034
  EXPECTED_LINTER_COMMANDS_ARRAY_GO_MODULES=("${BASE_LINTER_COMMANDS_ARRAY_GO_MODULES[@]}" "${INPUT_CONSUME_COMMAND[@]}")

  # Add some custom options to the Rust command to ensure that they are added before the "input consume" command
  # shellcheck disable=SC2034
  local RUST_CLIPPY_COMMAND_OPTIONS_ARRAY=("--verbose --help")
  RUST_CLIPPY_COMMAND_OPTIONS="${RUST_CLIPPY_COMMAND_OPTIONS_ARRAY[*]}"

  # Source the file again so it accounts for modifications
  # shellcheck source=/dev/null
  source "lib/functions/linterCommands.sh"

  # shellcheck disable=SC2034
  EXPECTED_LINTER_COMMANDS_ARRAY_RUST_CLIPPY=("${BASE_LINTER_COMMANDS_ARRAY_RUST_CLIPPY[@]}" "${RUST_CLIPPY_COMMAND_OPTIONS_ARRAY[@]}" "${INPUT_CONSUME_COMMAND[@]}")

  if ! InitInputConsumeCommands; then
    fatal "Error while initializing GNU parallel input consume commands"
  fi

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_ANSIBLE" "EXPECTED_LINTER_COMMANDS_ARRAY_ANSIBLE"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_GO_MODULES" "EXPECTED_LINTER_COMMANDS_ARRAY_GO_MODULES"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_RUST_CLIPPY" "EXPECTED_LINTER_COMMANDS_ARRAY_RUST_CLIPPY"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  notice "${FUNCTION_NAME} PASS"
}

function InitFixModeOptionsAndCommandsTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  LANGUAGE_ARRAY=("A" "B" "C")

  # Test a command that has only fix mode options to add
  # shellcheck disable=SC2034
  A_FIX_MODE_OPTIONS=(--fixA)

  # Test a command that has only check only mode options to add
  # shellcheck disable=SC2034
  B_CHECK_ONLY_MODE_TEST=(--checkB)

  # Test a command that has both fix mode and check only mode options to add
  # shellcheck disable=SC2034
  C_CHECK_ONLY_MODE_TEST=(--checkC)
  # shellcheck disable=SC2034
  C_FIX_MODE_OPTIONS=(--fixC)

  for LANGUAGE in "${LANGUAGE_ARRAY[@]}"; do
    local -n FIX_LANGUAGE_VARIABLE_NAME="FIX_${LANGUAGE}"

    # shellcheck disable=SC2034
    FIX_LANGUAGE_VARIABLE_NAME="true"

    local -n LINTER_COMMANDS_ARRAY="LINTER_COMMANDS_ARRAY_${LANGUAGE}"
    # shellcheck disable=SC2034
    LINTER_COMMANDS_ARRAY=("LINTER_COMMANDS_ARRAY_FOR_LINTER_${LANGUAGE}_FIX_MODE_TEST")
    EXPECTED_LINTER_COMMANDS_ARRAY_FIX_MODE=("${LINTER_COMMANDS_ARRAY[@]}")
    local FIX_MODE_OPTIONS_VARIABLE_NAME="${LANGUAGE}_FIX_MODE_OPTIONS"
    if [[ -v "${FIX_MODE_OPTIONS_VARIABLE_NAME}" ]]; then
      local -n FIX_MODE_OPTIONS="${FIX_MODE_OPTIONS_VARIABLE_NAME}"
      # shellcheck disable=SC2034
      EXPECTED_LINTER_COMMANDS_ARRAY_FIX_MODE+=("${FIX_MODE_OPTIONS[@]}")
      unset -n FIX_MODE_OPTIONS
    fi
    if ! InitFixModeOptionsAndCommands "${LANGUAGE}"; then
      fatal "InitFixModeOptionsAndCommands for ${LANGUAGE} should have passed validation"
    fi
    if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY" "EXPECTED_LINTER_COMMANDS_ARRAY_FIX_MODE"; then
      fatal "${FUNCTION_NAME} ${!FIX_LANGUAGE_VARIABLE_NAME}: ${FIX_LANGUAGE_VARIABLE_NAME} test failed"
    fi

    # shellcheck disable=SC2034
    FIX_LANGUAGE_VARIABLE_NAME="false"
    LINTER_COMMANDS_ARRAY=("LINTER_COMMANDS_ARRAY_FOR_LINTER_${LANGUAGE}_CHECK_ONLY_MODE_TEST")
    # shellcheck disable=SC2034
    EXPECTED_LINTER_COMMANDS_ARRAY_CHECK_ONLY_MODE=("${LINTER_COMMANDS_ARRAY[@]}")
    local CHECK_ONLY_MODE_OPTIONS_VARIABLE_NAME="${LANGUAGE}_CHECK_ONLY_MODE_OPTIONS"
    if [[ -v "${CHECK_ONLY_MODE_OPTIONS_VARIABLE_NAME}" ]]; then
      local -n CHECK_ONLY_MODE_OPTIONS="${CHECK_ONLY_MODE_OPTIONS_VARIABLE_NAME}"
      # shellcheck disable=SC2034
      EXPECTED_LINTER_COMMANDS_ARRAY_CHECK_ONLY_MODE+=("${CHECK_ONLY_MODE_OPTIONS[@]}")
      unset -n CHECK_ONLY_MODE_OPTIONS
    fi
    if ! InitFixModeOptionsAndCommands "${LANGUAGE}"; then
      fatal "InitFixModeOptionsAndCommands for ${LANGUAGE} should have passed validation"
    fi
    if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY" "EXPECTED_LINTER_COMMANDS_ARRAY_CHECK_ONLY_MODE"; then
      fatal "${FUNCTION_NAME} ${!FIX_LANGUAGE_VARIABLE_NAME}: ${FIX_LANGUAGE_VARIABLE_NAME} test failed"
    fi

    unset -n FIX_LANGUAGE_VARIABLE_NAME
    unset -n LINTER_COMMANDS_ARRAY
  done

  notice "${FUNCTION_NAME} PASS"
}

function InitPowerShellCommandTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # shellcheck disable=SC2034
  EXPECTED_LINTER_COMMANDS_ARRAY_POWERSHELL=(pwsh -NoProfile -NoLogo -Command "\"${LINTER_COMMANDS_ARRAY_POWERSHELL[*]}; if (\\\${Error}.Count) { exit 1 }\"")
  InitPowerShellCommand

  if ! AssertArraysElementsContentMatch "LINTER_COMMANDS_ARRAY_POWERSHELL" "EXPECTED_LINTER_COMMANDS_ARRAY_POWERSHELL"; then
    fatal "${FUNCTION_NAME} test failed"
  fi

  notice "${FUNCTION_NAME} PASS"
}

CommandOptionsTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  # Add custom arguments to linter commands that support them.
  # If possible, use command option that can run without modifying the filesystem,
  # and that don't need any input.

  # shellcheck disable=SC2034
  GITHUB_ACTIONS_COMMAND_ARGS="-color -debug -verbose -version"
  # shellcheck disable=SC2034
  JAVA_COMMAND_ARGS="-Dproperty1=value1 -version"
  # shellcheck disable=SC2034
  KUBERNETES_KUBECONFORM_OPTIONS="-debug -verbose -v"
  # shellcheck disable=SC2034
  PERL_PERLCRITIC_OPTIONS="--gentle --count test/linters/perl/perl_good_1.pl"
  # shellcheck disable=SC2034
  RUST_CLIPPY_COMMAND_OPTIONS="--verbose --help"

  # Source the file again so it accounts for modifications
  # shellcheck source=/dev/null
  source "lib/functions/linterCommands.sh"

  # Try running the commands
  "${LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS[@]}"
  "${LINTER_COMMANDS_ARRAY_JAVA[@]}"
  "${LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM[@]}"
  "${LINTER_COMMANDS_ARRAY_PERL[@]}"
  # Rust Clippy is only available in the standard image, so we can't run it when
  # testing the slim image
  if IsStandardImage; then
    "${LINTER_COMMANDS_ARRAY_RUST_CLIPPY[@]}"
  fi

  notice "${FUNCTION_NAME} PASS"
}

AddOptionsToCommandTest() {
  local FUNCTION_NAME
  FUNCTION_NAME="${FUNCNAME[0]}"
  info "${FUNCTION_NAME} start"

  local TEST_LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS=("${BASE_LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS[@]}")
  AddOptionsToCommand "TEST_LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS" "-color -debug -verbose -version"
  "${TEST_LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS[@]}"

  local TEST_LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM=("${BASE_LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM[@]}")
  AddOptionsToCommand "TEST_LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM" "-debug -verbose -v"
  "${TEST_LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM[@]}"

  local TEST_LINTER_COMMANDS_ARRAY_PERL=("${BASE_LINTER_COMMANDS_ARRAY_PERL[@]}")
  AddOptionsToCommand "TEST_LINTER_COMMANDS_ARRAY_PERL" "--gentle --count test/linters/perl/perl_good_1.pl"
  "${TEST_LINTER_COMMANDS_ARRAY_PERL[@]}"

  # Rust Clippy is only available in the standard image, so we can't run it when
  # testing the slim image
  if IsStandardImage; then
    local TEST_LINTER_COMMANDS_ARRAY_RUST_CLIPPY=("${BASE_LINTER_COMMANDS_ARRAY_RUST_CLIPPY[@]}")
    AddOptionsToCommand "TEST_LINTER_COMMANDS_ARRAY_RUST_CLIPPY" "--verbose --help"
    "${TEST_LINTER_COMMANDS_ARRAY_RUST_CLIPPY[@]}"
  fi

  notice "${FUNCTION_NAME} PASS"
}

LinterCommandPresenceTest
IgnoreGitIgnoredFilesJscpdCommandTest
JscpdCommandTest
EnableCommitlintStrictModeCommandTest
GitleaksCommandTest
GitleaksCommandCustomLogLevelTest
InitInputConsumeCommandsTest
InitFixModeOptionsAndCommandsTest
InitPowerShellCommandTest
CommandOptionsTest
AddOptionsToCommandTest
