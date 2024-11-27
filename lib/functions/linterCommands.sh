#!/usr/bin/env bash

# shellcheck disable=SC2034 # Disable ununsed variables warning because we
# source this script and use these variables as globals

# Load linter commands options so we don't need to load it every time we source
# source this file
# shellcheck source=/dev/null
source /action/lib/globals/linterCommandsOptions.sh

##########################
# Define linter commands #
##########################

# These commands are reused across several languages
PRETTIER_COMMAND=(prettier)
DOTNET_FORMAT_COMMAND=(dotnet format)

LINTER_COMMANDS_ARRAY_ANSIBLE=(ansible-lint -c "${ANSIBLE_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_ARM=(pwsh -NoProfile -NoLogo -Command "\"Import-Module ${ARM_TTK_PSD1} ; \\\${config} = \\\$(Import-PowerShellDataFile -Path ${ARM_LINTER_RULES}) ; Test-AzTemplate @config -TemplatePath '{}'; if (\\\${Error}.Count) { exit 1 }\"")
LINTER_COMMANDS_ARRAY_BASH=(shellcheck --color --rcfile "${BASH_LINTER_RULES}")
# This check and the BASH_SEVERITY variable are needed until Shellcheck supports
# setting severity using its config file.
# Ref: https://github.com/koalaman/shellcheck/issues/2178
if [ -n "${BASH_SEVERITY}" ]; then
  export BASH_SEVERITY
  LINTER_COMMANDS_ARRAY_BASH+=(--severity="${BASH_SEVERITY}")
fi
LINTER_COMMANDS_ARRAY_BASH_EXEC=(bash-exec '{}')
if [ "${BASH_EXEC_IGNORE_LIBRARIES}" == 'true' ]; then
  debug "Enabling bash-exec option to ignore shell library files."
  LINTER_COMMANDS_ARRAY_BASH_EXEC+=('true')
fi
LINTER_COMMANDS_ARRAY_CHECKOV=(checkov --config-file "${CHECKOV_LINTER_RULES}")
if CheckovConfigurationFileContainsDirectoryOption "${CHECKOV_LINTER_RULES}"; then
  # Consume the input as we do with ANSIBLE
  debug "Consume the input of the Checkov command because we don't need to add it as an argument."
  LINTER_COMMANDS_ARRAY_CHECKOV+=("&& echo \"Got the list of directories to lint from the configuration file: {}\"")
else
  debug "Adding the '--directory' option to the Checkov command."
  LINTER_COMMANDS_ARRAY_CHECKOV+=(--directory)
fi
LINTER_COMMANDS_ARRAY_CLANG_FORMAT=(clang-format --style=file:"${CLANG_FORMAT_LINTER_RULES}" --Werror)
LINTER_COMMANDS_ARRAY_CLOJURE=(clj-kondo --config "${CLOJURE_LINTER_RULES}" --lint)
LINTER_COMMANDS_ARRAY_CLOUDFORMATION=(cfn-lint --config-file "${CLOUDFORMATION_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_COFFEESCRIPT=(coffeelint -f "${COFFEESCRIPT_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_CPP=(cpplint)
LINTER_COMMANDS_ARRAY_CSHARP=("${DOTNET_FORMAT_COMMAND[@]}" whitespace --folder --exclude / --include "{/}")
LINTER_COMMANDS_ARRAY_CSS=(stylelint --config "${CSS_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_CSS_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_DART=(dart analyze --fatal-infos --fatal-warnings)
LINTER_COMMANDS_ARRAY_DOCKERFILE_HADOLINT=(hadolint -c "${DOCKERFILE_HADOLINT_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_DOTNET_SLN_FORMAT_ANALYZERS=("${DOTNET_FORMAT_COMMAND[@]}" analyzers)
LINTER_COMMANDS_ARRAY_DOTNET_SLN_FORMAT_STYLE=("${DOTNET_FORMAT_COMMAND[@]}" style)
LINTER_COMMANDS_ARRAY_DOTNET_SLN_FORMAT_WHITESPACE=("${DOTNET_FORMAT_COMMAND[@]}" whitespace)
LINTER_COMMANDS_ARRAY_EDITORCONFIG=(editorconfig-checker -config "${EDITORCONFIG_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_ENV=(dotenv-linter)
LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS=(actionlint -config-file "${GITHUB_ACTIONS_LINTER_RULES}")
if [ "${GITHUB_ACTIONS_COMMAND_ARGS}" != "null" ] && [ -n "${GITHUB_ACTIONS_COMMAND_ARGS}" ]; then
  export GITHUB_ACTIONS_COMMAND_ARGS
  AddOptionsToCommand "LINTER_COMMANDS_ARRAY_GITHUB_ACTIONS" "${GITHUB_ACTIONS_COMMAND_ARGS}"
fi
LINTER_COMMANDS_ARRAY_GITLEAKS=(gitleaks detect --no-banner --no-git --redact --config "${GITLEAKS_LINTER_RULES}" --verbose)
if [ -n "${GITLEAKS_LOG_LEVEL:-}" ]; then
  export GITLEAKS_LOG_LEVEL
  LINTER_COMMANDS_ARRAY_GITLEAKS+=("${GITLEAKS_LOG_LEVEL_OPTIONS[@]}" "${GITLEAKS_LOG_LEVEL}")
  debug "Add log options to the Gitleaks command: ${LINTER_COMMANDS_ARRAY_GITLEAKS[*]}"
fi
LINTER_COMMANDS_ARRAY_GITLEAKS+=(--source)
LINTER_COMMANDS_ARRAY_GHERKIN=(gherkin-lint -c "${GHERKIN_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_GIT_COMMITLINT=(commitlint --verbose --cwd "{}")
if [[ -n "${GITHUB_BEFORE_SHA:-}" ]]; then
  LINTER_COMMANDS_ARRAY_GIT_COMMITLINT+=(--from "${GITHUB_BEFORE_SHA}" --to "${GITHUB_SHA}")
else
  LINTER_COMMANDS_ARRAY_GIT_COMMITLINT+=(--last)
fi
if [ "${ENABLE_COMMITLINT_STRICT_MODE:-}" == 'true' ]; then
  LINTER_COMMANDS_ARRAY_GIT_COMMITLINT+=("${COMMITLINT_STRICT_MODE_OPTIONS[@]}")
fi
LINTER_COMMANDS_ARRAY_GIT_MERGE_CONFLICT_MARKERS=(git-merge-conflict-markers)
LINTER_COMMANDS_ARRAY_GO=(golangci-lint run -c "${GO_LINTER_RULES}" --fast)
LINTER_COMMANDS_ARRAY_GO_MODULES=(golangci-lint run --allow-parallel-runners -c "${GO_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_GO_RELEASER=(goreleaser check)
LINTER_COMMANDS_ARRAY_GOOGLE_JAVA_FORMAT=(java -jar /usr/bin/google-java-format)
LINTER_COMMANDS_ARRAY_GRAPHQL_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_GROOVY=(npm-groovy-lint -c "${GROOVY_LINTER_RULES}" --failon warning --no-insight)
LINTER_COMMANDS_ARRAY_HTML=(htmlhint --config "${HTML_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_HTML_PRETTIER=("${PRETTIER_COMMAND[@]}")
# Java checkstyle linter needs additional args passed _before_ the -jar arg
LINTER_COMMANDS_ARRAY_JAVA=(java)
if [ "${JAVA_COMMAND_ARGS}" != "null" ] && [ -n "${JAVA_COMMAND_ARGS}" ]; then
  export JAVA_COMMAND_ARGS
  AddOptionsToCommand "LINTER_COMMANDS_ARRAY_JAVA" "${JAVA_COMMAND_ARGS}"
fi
LINTER_COMMANDS_ARRAY_JAVA+=(-jar /usr/bin/checkstyle -c "${JAVA_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_JAVASCRIPT_ES=(eslint -c "${JAVASCRIPT_ES_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_JAVASCRIPT_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_JAVASCRIPT_STANDARD=(standard "${JAVASCRIPT_STANDARD_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_JSCPD=(jscpd --config "${JSCPD_LINTER_RULES}")
JSCPD_GITIGNORE_OPTION="--gitignore"
if [[ "${IGNORE_GITIGNORED_FILES}" == "true" ]]; then
  debug "IGNORE_GITIGNORED_FILES is ${IGNORE_GITIGNORED_FILES}. Enable Jscpd option to ignore files that Git ignores (${JSCPD_GITIGNORE_OPTION})"
  # Users can also add the '"gitignore": true' option in their Jscpd config files to achieve the same functionality
  # but we want to respect IGNORE_GITIGNORED_FILES
  LINTER_COMMANDS_ARRAY_JSCPD+=("${JSCPD_GITIGNORE_OPTION}")
fi
LINTER_COMMANDS_ARRAY_JSON=(eslint -c "${JAVASCRIPT_ES_LINTER_RULES}" --ext '.json')
LINTER_COMMANDS_ARRAY_JSON_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_JSONC=(eslint -c "${JAVASCRIPT_ES_LINTER_RULES}" --ext '.json5,.jsonc')
LINTER_COMMANDS_ARRAY_JSONC_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_JSX=(eslint -c "${JSX_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_JSX_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_KOTLIN=(ktlint "{/}")
LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM=(kubeconform -strict)
if [ "${KUBERNETES_KUBECONFORM_OPTIONS}" != "null" ] && [ -n "${KUBERNETES_KUBECONFORM_OPTIONS}" ]; then
  export KUBERNETES_KUBECONFORM_OPTIONS
  AddOptionsToCommand "LINTER_COMMANDS_ARRAY_KUBERNETES_KUBECONFORM" "${KUBERNETES_KUBECONFORM_OPTIONS}"
fi
LINTER_COMMANDS_ARRAY_LATEX=(chktex -q -l "${LATEX_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_LUA=(luacheck --config "${LUA_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_MARKDOWN=(markdownlint -c "${MARKDOWN_LINTER_RULES}")
if [ -n "${MARKDOWN_CUSTOM_RULE_GLOBS}" ]; then
  IFS="," read -r -a MARKDOWN_CUSTOM_RULE_GLOBS_ARRAY <<<"${MARKDOWN_CUSTOM_RULE_GLOBS}"
  for glob in "${MARKDOWN_CUSTOM_RULE_GLOBS_ARRAY[@]}"; do
    if [ -z "${LINTER_RULES_PATH}" ]; then
      LINTER_COMMANDS_ARRAY_MARKDOWN+=(-r "${GITHUB_WORKSPACE}/${glob}")
    else
      LINTER_COMMANDS_ARRAY_MARKDOWN+=(-r "${GITHUB_WORKSPACE}/${LINTER_RULES_PATH}/${glob}")
    fi
  done
fi
LINTER_COMMANDS_ARRAY_MARKDOWN_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_NATURAL_LANGUAGE=(textlint -c "${NATURAL_LANGUAGE_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_OPENAPI=(spectral lint -r "${OPENAPI_LINTER_RULES}" -D)
LINTER_COMMANDS_ARRAY_PERL=(perlcritic)
if [ "${PERL_PERLCRITIC_OPTIONS}" != "null" ] && [ -n "${PERL_PERLCRITIC_OPTIONS}" ]; then
  export PERL_PERLCRITIC_OPTIONS
  AddOptionsToCommand "LINTER_COMMANDS_ARRAY_PERL" "${PERL_PERLCRITIC_OPTIONS}"
fi
LINTER_COMMANDS_ARRAY_PHP_BUILTIN=(php -l -c "${PHP_BUILTIN_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PHP_PHPCS=(phpcs --standard="${PHP_PHPCS_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PHP_PHPSTAN=(phpstan analyse --no-progress --no-ansi --memory-limit 1G -c "${PHP_PHPSTAN_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PHP_PSALM=(psalm --config="${PHP_PSALM_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_POWERSHELL=(Invoke-ScriptAnalyzer -EnableExit -Settings "${POWERSHELL_LINTER_RULES}" -Path '{}')
LINTER_COMMANDS_ARRAY_PROTOBUF=(protolint lint -config_path "${PROTOBUF_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PYTHON_BLACK=(black --config "${PYTHON_BLACK_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PYTHON_PYLINT=(pylint --rcfile "${PYTHON_PYLINT_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PYTHON_FLAKE8=(flake8 --config="${PYTHON_FLAKE8_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PYTHON_ISORT=(isort --sp "${PYTHON_ISORT_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PYTHON_MYPY=(mypy --config-file "${PYTHON_MYPY_LINTER_RULES}" --install-types --non-interactive)
LINTER_COMMANDS_ARRAY_PYTHON_PYINK=(pyink --config "${PYTHON_PYINK_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_PYTHON_RUFF=(ruff check --config "${PYTHON_RUFF_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_R=(R --slave -e "\"lints <- lintr::lint('{}');print(lints);errors <- purrr::keep(lints, ~ .\\\$type == 'error');quit(save = 'no', status = if (length(errors) > 0) 1 else 0)\"")
LINTER_COMMANDS_ARRAY_RAKU=(raku)
LINTER_COMMANDS_ARRAY_RENOVATE=(renovate-config-validator --strict)
LINTER_COMMANDS_ARRAY_RUBY=(rubocop -c "${RUBY_LINTER_RULES}" --force-exclusion --ignore-unrecognized-cops)
LINTER_COMMANDS_ARRAY_RUST_2015=(rustfmt --edition 2015)
LINTER_COMMANDS_ARRAY_RUST_2018=(rustfmt --edition 2018)
LINTER_COMMANDS_ARRAY_RUST_2021=(rustfmt --edition 2021)
LINTER_COMMANDS_ARRAY_RUST_CLIPPY=(cargo clippy)
if [ -n "${RUST_CLIPPY_COMMAND_OPTIONS:-}" ]; then
  export RUST_CLIPPY_COMMAND_OPTIONS
  AddOptionsToCommand "LINTER_COMMANDS_ARRAY_RUST_CLIPPY" "${RUST_CLIPPY_COMMAND_OPTIONS}"
fi
LINTER_COMMANDS_ARRAY_SCALAFMT=(scalafmt --config "${SCALAFMT_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_SHELL_SHFMT=(shfmt)
LINTER_COMMANDS_ARRAY_SNAKEMAKE_LINT=(snakemake --lint -s)
LINTER_COMMANDS_ARRAY_SNAKEMAKE_SNAKEFMT=(snakefmt --config "${SNAKEMAKE_SNAKEFMT_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_STATES=(asl-validator --json-path)
LINTER_COMMANDS_ARRAY_SQLFLUFF=(sqlfluff)
LINTER_COMMANDS_ARRAY_TEKTON=(tekton-lint)
LINTER_COMMANDS_ARRAY_TERRAFORM_FMT=(terraform fmt)
LINTER_COMMANDS_ARRAY_TERRAFORM_TFLINT=("TF_DATA_DIR=\"/tmp/.terraform-TERRAFORM_TFLINT-{//}\"" tflint -c "${TERRAFORM_TFLINT_LINTER_RULES}" "--filter=\"{/}\"")
LINTER_COMMANDS_ARRAY_TERRAFORM_TERRASCAN=(terrascan scan -i terraform -t all -c "${TERRAFORM_TERRASCAN_LINTER_RULES}" -f)
LINTER_COMMANDS_ARRAY_TERRAGRUNT=(terragrunt hclfmt --terragrunt-check --terragrunt-log-level error --terragrunt-hclfmt-file)
LINTER_COMMANDS_ARRAY_TSX=(eslint -c "${TSX_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_TYPESCRIPT_ES=(eslint -c "${TYPESCRIPT_ES_LINTER_RULES}")
LINTER_COMMANDS_ARRAY_TYPESCRIPT_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_TYPESCRIPT_STANDARD=(ts-standard --parser @typescript-eslint/parser --plugin @typescript-eslint/eslint-plugin --project "${TYPESCRIPT_STANDARD_TSCONFIG_FILE}")
LINTER_COMMANDS_ARRAY_VUE_PRETTIER=("${PRETTIER_COMMAND[@]}")
LINTER_COMMANDS_ARRAY_XML=(xmllint)
LINTER_COMMANDS_ARRAY_YAML=(yamllint -c "${YAML_LINTER_RULES}" -f parsable)
if [ "${YAML_ERROR_ON_WARNING}" == 'true' ]; then
  LINTER_COMMANDS_ARRAY_YAML+=(--strict)
fi
LINTER_COMMANDS_ARRAY_YAML_PRETTIER=("${PRETTIER_COMMAND[@]}")

function InitFixModeOptionsAndCommands() {
  local LANGUAGE="${1}"
  local FIX_MODE_VARIABLE_NAME="FIX_${LANGUAGE}"
  debug "Check if ${LANGUAGE} command needs check only mode or fix mode options or commands by checking if ${FIX_MODE_VARIABLE_NAME} variable is defined."

  if [[ -v "${FIX_MODE_VARIABLE_NAME}" ]]; then
    debug "${FIX_MODE_VARIABLE_NAME} is set. Check if we need to add check only mode options or fix mode options or commands."

    local FIX_MODE_OPTIONS_REF_VARIABLE_NAME="${LANGUAGE}_FIX_MODE_OPTIONS"
    local -n FIX_MODE_OPTIONS_REF="${FIX_MODE_OPTIONS_REF_VARIABLE_NAME}"

    local OPTIONS_VARIABLE_NAME="${LANGUAGE}"

    local -n FIX_MODE_REF="${FIX_MODE_VARIABLE_NAME}"
    if [[ "${FIX_MODE_REF}" == "true" ]]; then
      debug "Fix mode for ${LANGUAGE} is enabled. Check if ${LANGUAGE} needs options to enable fix mode."
      OPTIONS_VARIABLE_NAME="${OPTIONS_VARIABLE_NAME}_FIX_MODE_OPTIONS"
    else
      debug "Fix mode for ${LANGUAGE} is not enabled. Check if ${LANGUAGE} needs options to enable check mode."
      OPTIONS_VARIABLE_NAME="${OPTIONS_VARIABLE_NAME}_CHECK_ONLY_MODE_OPTIONS"
    fi

    local -a OPTIONS_TO_ADD_ARRAY
    OPTIONS_TO_ADD_ARRAY=()
    if [[ -v "${OPTIONS_VARIABLE_NAME}" ]]; then
      local -n MODE_OPTIONS="${OPTIONS_VARIABLE_NAME}"
      debug "${!MODE_OPTIONS} is defined. Contents: ${MODE_OPTIONS[*]}"
      OPTIONS_TO_ADD_ARRAY=("${MODE_OPTIONS[@]}")
      unset -n MODE_OPTIONS
    else
      debug "There are no options or commands for check only mode or fix mode to add at the end of the command for ${LANGUAGE}"
    fi

    local -n LINTER_COMMAND_ARRAY="LINTER_COMMANDS_ARRAY_${LANGUAGE}"
    debug "Load command for ${LANGUAGE}: ${!LINTER_COMMAND_ARRAY}. Contents: ${LINTER_COMMAND_ARRAY[*]}"
    if [[ "${#OPTIONS_TO_ADD_ARRAY[@]}" -gt 0 ]]; then
      debug "There are ${#OPTIONS_TO_ADD_ARRAY[@]} options to add at the end of the command for ${LANGUAGE}: ${OPTIONS_TO_ADD_ARRAY[*]}"
      LINTER_COMMAND_ARRAY=("${LINTER_COMMAND_ARRAY[@]}" "${OPTIONS_TO_ADD_ARRAY[@]}")
      debug "Add options at the end of the command for ${LANGUAGE}. Result: ${LINTER_COMMAND_ARRAY[*]}"
    else
      debug "${LANGUAGE} doesn't need any further options or commands for fix mode or check mode."
    fi

    debug "Completed the initialization of linter command for ${LANGUAGE}. Result: ${LINTER_COMMAND_ARRAY[*]}"

    unset -n LINTER_COMMAND_ARRAY
    unset -n FIX_MODE_REF
    unset -n FIX_MODE_OPTIONS_REF
  else
    debug "${FIX_MODE_VARIABLE_NAME} is not set. Don't add check only mode options or fix mode options or commands for ${LANGUAGE}."
  fi
}

function InitInputConsumeCommands() {
  LINTER_COMMANDS_ARRAY_ANSIBLE+=("${INPUT_CONSUME_COMMAND[@]}")
  LINTER_COMMANDS_ARRAY_GO_MODULES+=("${INPUT_CONSUME_COMMAND[@]}")
  LINTER_COMMANDS_ARRAY_RUST_CLIPPY+=("${INPUT_CONSUME_COMMAND[@]}")
}

function InitPowerShellCommand() {
  debug "PowerShell command before initialization: ${LINTER_COMMANDS_ARRAY_POWERSHELL[*]}"
  LINTER_COMMANDS_ARRAY_POWERSHELL=(pwsh -NoProfile -NoLogo -Command "\"${LINTER_COMMANDS_ARRAY_POWERSHELL[*]}; if (\\\${Error}.Count) { exit 1 }\"")
  debug "PowerShell command after initialization: ${LINTER_COMMANDS_ARRAY_POWERSHELL[*]}"
}

AddOptionsToCommand() {
  local -n COMMAND_ARRAY_NAME="${1}"
  local COMMAND_OPTIONS_TO_ADD="${2}"
  local COMMAND_OPTIONS_TO_ADD_ARRAY

  debug "Adding options to ${!COMMAND_ARRAY_NAME}: ${COMMAND_OPTIONS_TO_ADD}"

  IFS=" " read -r -a COMMAND_OPTIONS_TO_ADD_ARRAY <<<"${COMMAND_OPTIONS_TO_ADD}"
  debug "Options to add to ${!COMMAND_ARRAY_NAME} as an array: ${COMMAND_OPTIONS_TO_ADD_ARRAY[*]}"

  COMMAND_ARRAY_NAME+=("${COMMAND_OPTIONS_TO_ADD_ARRAY[@]}")
  debug "${!COMMAND_ARRAY_NAME} after adding options: ${COMMAND_ARRAY_NAME[*]}"

  unset -n COMMAND_ARRAY_NAME
}
