#!/usr/bin/env bash

set -euo pipefail

# Reference: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7
# Slightly modified to always retrieve latest stable Powershell version
# If changing PWSH_VERSION='latest' to a specific version, use format PWSH_VERSION='tags/v7.0.2'

mkdir -p "${PWSH_DIRECTORY}"
url=$(curl -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(cat /run/secrets/GITHUB_TOKEN)" \
  "https://api.github.com/repos/powershell/powershell/releases/${PWSH_VERSION}" |
  jq -r '.assets | .[] | select(.name | contains("linux-alpine-x64")) | .url')
curl --retry 5 --retry-delay 5 -sL \
  -H "Accept: application/octet-stream" \
  -H "Authorization: Bearer $(cat /run/secrets/GITHUB_TOKEN)" \
  "${url}" | tar -xz -C "${PWSH_DIRECTORY}"
chmod +x "${PWSH_DIRECTORY}/pwsh"
ln -sf "${PWSH_DIRECTORY}/pwsh" /usr/bin/pwsh
pwsh -c "Install-Module -Name PSScriptAnalyzer -RequiredVersion ${PSSA_VERSION} -Scope AllUsers -Force"
