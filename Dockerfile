####################################
####################################
## Dockerfile to run Super-Linter ##
####################################
####################################

#########################################
# Get dependency images as build stages #
#########################################
FROM tenable/terrascan:1.19.9 AS terrascan
FROM alpine/terragrunt:1.10.3 AS terragrunt
FROM dotenvlinter/dotenv-linter:3.3.0 AS dotenv-linter
FROM ghcr.io/terraform-linters/tflint:v0.55.0 AS tflint
FROM ghcr.io/yannh/kubeconform:v0.6.7 AS kubeconfrm
FROM alpine/helm:3.16.4 AS helm
FROM golang:1.23.4-alpine AS golang
FROM golangci/golangci-lint:v1.63.4 AS golangci-lint
FROM goreleaser/goreleaser:v2.5.1 AS goreleaser
FROM hadolint/hadolint:v2.12.0-alpine AS dockerfile-lint
FROM registry.k8s.io/kustomize/kustomize:v5.4.3 AS kustomize
FROM hashicorp/terraform:1.10.4 AS terraform
FROM koalaman/shellcheck:v0.10.0 AS shellcheck
FROM mstruebing/editorconfig-checker:v3.1.2 AS editorconfig-checker
FROM mvdan/shfmt:v3.10.0 AS shfmt
FROM rhysd/actionlint:1.7.6 AS actionlint
FROM scalameta/scalafmt:v3.8.3 AS scalafmt
FROM zricethezav/gitleaks:v8.22.1 AS gitleaks
FROM yoheimuta/protolint:0.52.0 AS protolint
FROM ghcr.io/clj-kondo/clj-kondo:2024.11.14-alpine AS clj-kondo
FROM dart:3.6.1-sdk AS dart
FROM mcr.microsoft.com/dotnet/sdk:9.0.101-alpine3.20 AS dotnet-sdk
FROM mcr.microsoft.com/powershell:7.4-alpine-3.20 AS powershell
FROM composer/composer:2.8.4 AS php-composer

FROM python:3.12.7-alpine3.20 AS clang-format

RUN apk add --no-cache \
  build-base \
  clang17 \
  cmake \
  git \
  llvm17-dev \
  ninja-is-really-ninja

WORKDIR /tmp
RUN git clone \
  --branch "llvmorg-$(llvm-config  --version)" \
  --depth 1 \
  https://github.com/llvm/llvm-project.git

WORKDIR /tmp/llvm-project/llvm/build
RUN cmake \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DLLVM_BUILD_STATIC=ON \
  -DLLVM_ENABLE_PROJECTS=clang \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ .. \
  && ninja clang-format \
  && mv /tmp/llvm-project/llvm/build/bin/clang-format /usr/bin

FROM python:3.12.7-alpine3.20 AS python-builder

RUN apk add --no-cache \
  bash

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

COPY dependencies/python/ /stage
WORKDIR /stage
RUN ./build-venvs.sh && rm -rfv /stage

FROM python:3.12.7-alpine3.20 AS npm-builder

RUN apk add --no-cache \
  bash \
  nodejs-current

# The chown fixes broken uid/gid in ast-types-flow dependency
# (see https://github.com/super-linter/super-linter/issues/3901)
# Npm is not a runtime dependency but we need it to ensure that npm packages
# are installed when we run the test suite. If we decide to remove it, add
# the following command to the RUN instruction below:
# apk del --no-network --purge .node-build-deps
COPY dependencies/package.json dependencies/package-lock.json /
RUN apk add --no-cache --virtual .node-build-deps \
  npm \
  && npm install --strict-peer-deps \
  && npm cache clean --force \
  && chown -R "$(id -u)":"$(id -g)" node_modules \
  && rm -rfv package.json package-lock.json

FROM tflint AS tflint-plugins

# Configure TFLint plugin folder
ENV TFLINT_PLUGIN_DIR="/root/.tflint.d/plugins"

# Copy TFlint configuration file because it contains plugin definitions
COPY TEMPLATES/.tflint.hcl /action/lib/.automation/

# Initialize TFLint plugins so we get plugin versions listed when we ask for TFLint version
RUN --mount=type=secret,id=GITHUB_TOKEN GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN) tflint --init -c /action/lib/.automation/.tflint.hcl

FROM python:3.12.7-alpine3.20 AS lintr-installer

RUN apk add --no-cache \
  bash \
  R

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

COPY scripts/install-lintr.sh scripts/install-r-package-or-fail.R /
RUN /install-lintr.sh && rm -rf /install-lintr.sh /install-r-package-or-fail.R

FROM powershell AS powershell-installer

# Copy the value of the PowerShell install directory to a file so we can reuse it
# when copying PowerShell stuff in the main image
RUN echo "${PS_INSTALL_FOLDER}" > /tmp/PS_INSTALL_FOLDER

FROM php-composer AS php-linters

COPY dependencies/composer/composer.json dependencies/composer/composer.lock /app/

RUN composer update \
  && composer audit

FROM python:3.12.7-alpine3.20 AS base_image

LABEL com.github.actions.name="Super-Linter" \
  com.github.actions.description="Super-linter is a ready-to-run collection of linters and code analyzers, to help validate your source code." \
  com.github.actions.icon="code" \
  com.github.actions.color="red" \
  maintainer="@Hanse00, @ferrarimarco, @zkoppert" \
  org.opencontainers.image.authors="Super Linter Contributors: https://github.com/super-linter/super-linter/graphs/contributors" \
  org.opencontainers.image.url="https://github.com/super-linter/super-linter" \
  org.opencontainers.image.source="https://github.com/super-linter/super-linter" \
  org.opencontainers.image.documentation="https://github.com/super-linter/super-linter" \
  org.opencontainers.image.description="A collection of code linters and analyzers."

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH

# Install bash first so we can use it
# This is also a super-linter runtime dependency
RUN apk add --no-cache \
  bash

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

# Install super-linter runtime dependencies
# Npm is not a runtime dependency but we need it to ensure that npm packages
# are installed when we run the test suite.
RUN apk add --no-cache \
  ca-certificates \
  coreutils \
  curl \
  file \
  git \
  git-lfs \
  jq \
  libxml2-utils \
  npm \
  nodejs-current \
  openjdk17-jre \
  openssh-client \
  parallel \
  perl \
  php83 \
  php83-ctype \
  php83-curl \
  php83-dom \
  php83-iconv \
  php83-pecl-igbinary \
  php83-intl \
  php83-mbstring \
  php83-openssl \
  php83-phar \
  php83-simplexml \
  php83-tokenizer \
  php83-xmlwriter \
  R \
  rakudo \
  ruby \
  zef

# Install Ruby tools
COPY dependencies/Gemfile dependencies/Gemfile.lock /
RUN apk add --no-cache --virtual .ruby-build-deps \
  gcc \
  make \
  musl-dev \
  ruby-bundler \
  ruby-dev \
  ruby-rdoc \
  && bundle install \
  && apk del --no-network --purge .ruby-build-deps \
  && rm -rf Gemfile Gemfile.lock

##############################
# Installs Perl dependencies #
##############################
RUN apk add --no-cache --virtual .perl-build-deps \
  gcc \
  make \
  musl-dev \
  perl-dev \
  && curl --retry 5 --retry-delay 5 -sL https://cpanmin.us/ \
  | perl - -nq --no-wget \
  Perl::Critic \
  Perl::Critic::Bangs \
  Perl::Critic::Community \
  Perl::Critic::Lax \
  Perl::Critic::More \
  Perl::Critic::StricterSubs \
  Perl::Critic::Swift \
  Perl::Critic::Tics \
  && rm -rf /root/.cpanm \
  && apk del --no-network --purge .perl-build-deps

#################
# Install glibc #
#################
COPY scripts/install-glibc.sh /
RUN --mount=type=secret,id=GITHUB_TOKEN /install-glibc.sh \
  && rm -rf /install-glibc.sh

##################
# Install chktex #
##################
COPY scripts/install-chktex.sh /
RUN --mount=type=secret,id=GITHUB_TOKEN /install-chktex.sh && rm -rf /install-chktex.sh
# Set work directory back to root because some scripts depend on it
WORKDIR /

#################################
# Install luacheck and luarocks #
#################################
COPY scripts/install-lua.sh /
RUN --mount=type=secret,id=GITHUB_TOKEN /install-lua.sh && rm -rf /install-lua.sh

############################
# Install PHP dependencies #
############################
ENV PHP_COMPOSER_PACKAGES_DIR=/php-composer/vendor
COPY --from=php-composer /usr/bin/composer /usr/bin/
COPY --from=php-linters /app/vendor "${PHP_COMPOSER_PACKAGES_DIR}"

##################
# Install ktlint #
##################
COPY scripts/install-ktlint.sh /
COPY dependencies/ktlint /ktlint
RUN --mount=type=secret,id=GITHUB_TOKEN /install-ktlint.sh \
  && rm -rfv /install-ktlint.sh /ktlint

######################
# Install CheckStyle #
######################
COPY scripts/install-checkstyle.sh /
COPY dependencies/checkstyle /checkstyle
RUN --mount=type=secret,id=GITHUB_TOKEN /install-checkstyle.sh \
  && rm -rfv /install-checkstyle.sh /checkstyle

##############################
# Install google-java-format #
##############################
COPY scripts/install-google-java-format.sh /
COPY dependencies/google-java-format /google-java-format
RUN --mount=type=secret,id=GITHUB_TOKEN /install-google-java-format.sh \
  && rm -rfv /install-google-java-format.sh /google-java-format

################
# Install Helm #
################
COPY --from=helm /usr/bin/helm /usr/bin/

COPY --from=kustomize /app/kustomize /usr/bin/

# Copy Node tools
COPY --from=npm-builder /node_modules /node_modules

######################
# Install shellcheck #
######################
COPY --from=shellcheck /bin/shellcheck /usr/bin/

#####################
# Install Go Linter #
#####################
COPY --from=golang /usr/local/go/go.env /usr/lib/go/
COPY --from=golang /usr/local/go/bin/ /usr/lib/go/bin/
COPY --from=golang /usr/local/go/lib/ /usr/lib/go/lib/
COPY --from=golang /usr/local/go/pkg/ /usr/lib/go/pkg/
COPY --from=golang /usr/local/go/src/ /usr/lib/go/src/
COPY --from=golangci-lint /usr/bin/golangci-lint /usr/bin/

######################
# Install GoReleaser #
######################
COPY --from=goreleaser /usr/bin/goreleaser /usr/bin/

#####################
# Install Terraform #
#####################
COPY --from=terraform /bin/terraform /usr/bin/

##################
# Install TFLint #
##################
# Configure TFLint plugin folder
ENV TFLINT_PLUGIN_DIR="/root/.tflint.d/plugins"
COPY --from=tflint /usr/local/bin/tflint /usr/bin/
COPY --from=tflint-plugins "${TFLINT_PLUGIN_DIR}" "${TFLINT_PLUGIN_DIR}"

#####################
# Install Terrascan #
#####################
COPY --from=terrascan /go/bin/terrascan /usr/bin/

######################
# Install Terragrunt #
######################
COPY --from=terragrunt /usr/local/bin/terragrunt /usr/bin/

######################
# Install protolint #
######################
COPY --from=protolint /usr/local/bin/protolint /usr/bin/

################################
# Install editorconfig-checker #
################################
COPY --from=editorconfig-checker /usr/bin/ec /usr/bin/editorconfig-checker

###############################
# Install hadolint dockerfile #
###############################
COPY --from=dockerfile-lint /bin/hadolint /usr/bin/hadolint

#################
# Install shfmt #
#################
COPY --from=shfmt /bin/shfmt /usr/bin/

####################
# Install GitLeaks #
####################
COPY --from=gitleaks /usr/bin/gitleaks /usr/bin/

####################
# Install scalafmt #
####################
COPY --from=scalafmt /bin/scalafmt /usr/bin/
RUN scalafmt --version | awk ' { print $2 }' > /tmp/scalafmt-version.txt

######################
# Install actionlint #
######################
COPY --from=actionlint /usr/local/bin/actionlint /usr/bin/

######################
# Install kubeconform #
######################
COPY --from=kubeconfrm /kubeconform /usr/bin/

#####################
# Install clj-kondo #
#####################
COPY --from=clj-kondo /bin/clj-kondo /usr/bin/

####################
# Install dart-sdk #
####################
ENV DART_SDK=/usr/lib/dart
COPY --from=dart "${DART_SDK}" "${DART_SDK}"
RUN chmod 755 "${DART_SDK}" && chmod 755 "${DART_SDK}/bin"

########################
# Install clang-format #
########################
COPY --from=clang-format /usr/bin/clang-format /usr/bin/

########################
# Install python tools #
########################
COPY --from=python-builder /venvs /venvs

#################
# Install Lintr #
#################
COPY --from=lintr-installer /usr/lib/R /usr/lib/R

##########################################
# Install linters implemented as scripts #
##########################################
COPY --chmod=555 scripts/bash-exec.sh /usr/bin/bash-exec
COPY --chmod=555 scripts/git-merge-conflict-markers.sh /usr/bin/git-merge-conflict-markers

#########################
# Install dotenv-linter #
#########################
COPY --from=dotenv-linter /dotenv-linter /usr/bin/

#########################
# Configure Environment #
#########################
ENV PATH="${PATH}:/venvs/ansible-lint/bin"
ENV PATH="${PATH}:/venvs/black/bin"
ENV PATH="${PATH}:/venvs/checkov/bin"
ENV PATH="${PATH}:/venvs/cfn-lint/bin"
ENV PATH="${PATH}:/venvs/cpplint/bin"
ENV PATH="${PATH}:/venvs/flake8/bin"
ENV PATH="${PATH}:/venvs/isort/bin"
ENV PATH="${PATH}:/venvs/mypy/bin"
ENV PATH="${PATH}:/venvs/nbqa/bin"
ENV PATH="${PATH}:/venvs/pyink/bin"
ENV PATH="${PATH}:/venvs/pylint/bin"
ENV PATH="${PATH}:/venvs/ruff/bin"
ENV PATH="${PATH}:/venvs/snakefmt/bin"
ENV PATH="${PATH}:/venvs/snakemake/bin"
ENV PATH="${PATH}:/venvs/sqlfluff/bin"
ENV PATH="${PATH}:/venvs/yamllint/bin"
ENV PATH="${PATH}:/venvs/yq/bin"
ENV PATH="${PATH}:/node_modules/.bin"
ENV PATH="${PATH}:/usr/lib/go/bin"
ENV PATH="${PATH}:${DART_SDK}/bin:/root/.pub-cache/bin"
ENV PATH="${PATH}:${PHP_COMPOSER_PACKAGES_DIR}/bin"

# Renovate optionally requires re2, and will warn if its not present
# Setting this envoronment variable disables this warning.
ENV RENOVATE_X_IGNORE_RE2="true"

# File to store linter versions
ENV VERSION_FILE="/action/linterVersions.txt"
RUN mkdir /action

# create the homedir, so that in case it is not present (like on action-runner-controller based selfhosted runners)
# we do not fail at setting /github/workspace as a safe git directory
ENV HOME="/github/home"
RUN mkdir -p "${HOME}"

ENTRYPOINT ["/action/lib/linter.sh"]

FROM base_image AS slim

# Run to build version file and validate image
ENV IMAGE="slim"
COPY scripts/linterVersions.sh /
RUN /linterVersions.sh \
  && rm -rfv /linterVersions.sh

###################################
# Copy linter configuration files #
###################################
COPY TEMPLATES /action/lib/.automation

# Dynamically set scalafmt version in the scalafmt configuration file
# Ref: https://scalameta.org/scalafmt/docs/configuration.html#version
COPY --from=base_image /tmp/scalafmt-version.txt /tmp/scalafmt-version.txt
RUN echo "version = $(cat /tmp/scalafmt-version.txt)" >> /action/lib/.automation/.scalafmt.conf \
  && rm /tmp/scalafmt-version.txt

#################################
# Copy super-linter executables #
#################################
COPY lib /action/lib

# Set build metadata here so we don't invalidate the container image cache if we
# change the values of these arguments
ARG BUILD_DATE
ARG BUILD_REVISION
ARG BUILD_VERSION

LABEL org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.revision=$BUILD_REVISION \
  org.opencontainers.image.version=$BUILD_VERSION

ENV BUILD_DATE=$BUILD_DATE
ENV BUILD_REVISION=$BUILD_REVISION
ENV BUILD_VERSION=$BUILD_VERSION

##############################
# Build the standard variant #
##############################
FROM base_image AS standard

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH

ENV ARM_TTK_PSD1="/usr/lib/microsoft/arm-ttk/arm-ttk.psd1"
ENV PATH="${PATH}:/var/cache/dotnet/tools:/usr/share/dotnet"

# Install super-linter runtime dependencies
RUN apk add --no-cache \
  rust-clippy \
  rustfmt

###################################
# Install DotNet and Dependencies #
###################################
COPY --from=dotnet-sdk /usr/share/dotnet /usr/share/dotnet
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
# Trigger first run experience by running arbitrary cmd
RUN dotnet help

#########################################
# Install Powershell + PSScriptAnalyzer #
#########################################
COPY --from=powershell-installer /tmp/PS_INSTALL_FOLDER /tmp/PS_INSTALL_FOLDER
COPY --from=powershell /opt/microsoft/powershell /opt/microsoft/powershell
# Disable Powershell telemetry
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ARG PSSA_VERSION='1.22.0'
RUN PS_INSTALL_FOLDER="$(cat /tmp/PS_INSTALL_FOLDER)" \
  && echo "PS_INSTALL_FOLDER: ${PS_INSTALL_FOLDER}" \
  && ln -s "${PS_INSTALL_FOLDER}/pwsh" /usr/bin/pwsh \
  && chmod a+x,o-w "${PS_INSTALL_FOLDER}/pwsh" \
  && pwsh -c "Install-Module -Name PSScriptAnalyzer -RequiredVersion ${PSSA_VERSION} -Scope AllUsers -Force" \
  && rm -rf /tmp/PS_INSTALL_FOLDER

#############################################################
# Install Azure Resource Manager Template Toolkit (arm-ttk) #
#############################################################
COPY scripts/install-arm-ttk.sh /
RUN --mount=type=secret,id=GITHUB_TOKEN /install-arm-ttk.sh && rm -rf /install-arm-ttk.sh

# Run to build version file and validate image again because we installed more linters
ENV IMAGE="standard"
COPY scripts/linterVersions.sh /
RUN /linterVersions.sh \
  && rm -rfv /linterVersions.sh

###################################
# Copy linter configuration files #
###################################
COPY TEMPLATES /action/lib/.automation

# Dynamically set scalafmt version in the scalafmt configuration file
# Ref: https://scalameta.org/scalafmt/docs/configuration.html#version
COPY --from=base_image /tmp/scalafmt-version.txt /tmp/scalafmt-version.txt
RUN echo "version = $(cat /tmp/scalafmt-version.txt)" >> /action/lib/.automation/.scalafmt.conf \
  && rm /tmp/scalafmt-version.txt

#################################
# Copy super-linter executables #
#################################
COPY lib /action/lib

# Set build metadata here so we don't invalidate the container image cache if we
# change the values of these arguments
ARG BUILD_DATE
ARG BUILD_REVISION
ARG BUILD_VERSION

LABEL org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.revision=$BUILD_REVISION \
  org.opencontainers.image.version=$BUILD_VERSION

ENV BUILD_DATE=$BUILD_DATE
ENV BUILD_REVISION=$BUILD_REVISION
ENV BUILD_VERSION=$BUILD_VERSION
