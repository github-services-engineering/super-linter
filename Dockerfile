###########################################
###########################################
## Dockerfile to run GitHub Super-Linter ##
###########################################
###########################################

##################
# Get base image #
##################
FROM python:alpine

#########################################
# Label the instance and set maintainer #
#########################################
LABEL com.github.actions.name="GitHub Super-Linter" \
      com.github.actions.description="Lint your code base with GitHub Actions" \
      com.github.actions.icon="code" \
      com.github.actions.color="red" \
      maintainer="GitHub DevOps <github_devops@github.com>"

####################
# Run APK installs #
####################
RUN apk add --no-cache \
    bash git git-lfs musl-dev curl gcc jq file\
    npm nodejs \
    libxml2-utils perl \
    ruby ruby-dev ruby-bundler ruby-rdoc make \
    py3-setuptools ansible-lint \
    go

#####################
# Run Pip3 Installs #
#####################
RUN pip3 --no-cache-dir install --upgrade --no-cache-dir \
    yamllint pylint yq

####################
# Run NPM Installs #
####################
RUN npm config set package-lock false \
    && npm config set loglevel error \
    && npm -g --no-cache install \
      markdownlint-cli \
      jsonlint prettyjson \
      @coffeelint/cli \
      typescript eslint \
      standard \
      babel-eslint \
      @typescript-eslint/eslint-plugin \
      @typescript-eslint/parser \
      eslint-plugin-jest \
      stylelint \
      stylelint-config-standard \
      && npm --no-cache install \
      markdownlint-cli \
      jsonlint prettyjson \
      @coffeelint/cli \
      typescript eslint \
      standard \
      babel-eslint \
      prettier \
      eslint-config-prettier \
      @typescript-eslint/eslint-plugin \
      @typescript-eslint/parser \
      eslint-plugin-jest \
      stylelint \
      stylelint-config-standard

####################################
# Install dockerfilelint from repo #
####################################
RUN git clone https://github.com/replicatedhq/dockerfilelint.git && cd /dockerfilelint && npm install

 # I think we could fix this with path but not sure the language...
 # https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md

####################
# Run GEM installs #
####################
RUN gem install rubocop:0.74.0 rubocop-rails rubocop-github:0.13.0

# Need to fix the version as it installs 'rubocop:0.85.1' as a dep, and forces the default
# We then need to promot the correct verion, uninstall, and fix deps
RUN sh -c 'gem install --default rubocop:0.74.0;  yes | gem uninstall rubocop:0.85.1 -a -x -I; gem install rubocop:0.74.0'

######################
# Install shellcheck #
######################
RUN wget -qO- "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz" | tar -xJv \
    && mv "shellcheck-stable/shellcheck" /usr/bin/

#####################
# Install Go Linter #
#####################
ARG GO_VERSION='v1.27.0'
RUN wget -O- -nvq https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s "$GO_VERSION"

##################
# Install TFLint #
##################
RUN curl -Ls "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip \
    && mv "tflint" /usr/bin/

########################################
# Install Resharper Command Line Tools #
########################################
ARG RESHARPER_ULTIMATE_VERSION='2020.1.3'
RUN wget -qO- "https://download-cf.jetbrains.com/resharper/ReSharperUltimate.${RESHARPER_ULTIMATE_VERSION}/JetBrains.ReSharper.CommandLineTools.Unix.${RESHARPER_ULTIMATE_VERSION}.tar.gz)" -o resharper.tar.gz \
    && tar -xf resharper.tar.gz -C /usr/bin/resharper \
    && rm resharper.tar.gz

##################
# Install dotenv-linter #
##################
RUN wget "https://github.com/dotenv-linter/dotenv-linter/releases/latest/download/dotenv-linter-alpine-x86_64.tar.gz" -O - -q | tar -xzf - \
    && mv "dotenv-linter" /usr/bin

###########################################
# Load GitHub Env Vars for GitHub Actions #
###########################################
ENV GITHUB_SHA=${GITHUB_SHA} \
    GITHUB_EVENT_PATH=${GITHUB_EVENT_PATH} \
    GITHUB_WORKSPACE=${GITHUB_WORKSPACE} \
    DEFAULT_BRANCH=${DEFAULT_BRANCH} \
    VALIDATE_ALL_CODEBASE=${VALIDATE_ALL_CODEBASE} \
    VALIDATE_YAML=${VALIDATE_YAML} \
    VALIDATE_JSON=${VALIDATE_JSON} \
    VALIDATE_XML=${VALIDATE_XML} \
    VALIDATE_MD=${VALIDATE_MD} \
    VALIDATE_BASH=${VALIDATE_BASH} \
    VALIDATE_PERL=${VALIDATE_PERL} \
    VALIDATE_PYTHON=${VALIDATE_PYTHON} \
    VALIDATE_RUBY=${VALIDATE_RUBY} \
    VALIDATE_COFFEE=${VALIDATE_COFFEE} \
    VALIDATE_ANSIBLE=${VALIDATE_ANSIBLE} \
    VALIDATE_DOCKER=${VALIDATE_DOCKER} \
    VALIDATE_JAVASCRIPT_ES=${VALIDATE_JAVASCRIPT_ES} \
    VALIDATE_JAVASCRIPT_STANDARD=${VALIDATE_JAVASCRIPT_STANDARD} \
    VALIDATE_TYPESCRIPT_ES=${VALIDATE_TYPESCRIPT_ES} \
    VALIDATE_TYPESCRIPT_STANDARD=${VALIDATE_TYPESCRIPT_STANDARD} \
    VALIDATE_GO=${VALIDATE_GO} \
    VALIDATE_TERRAFORM=${VALIDATE_TERRAFORM} \
    VALIDATE_CSHARP=${VALIDATE_CSHARP} \
    VALIDATE_CSS=${VALIDATE_CSS} \
    VALIDATE_ENV=${VALIDATE_ENV} \
    ANSIBLE_DIRECTORY=${ANSIBLE_DIRECTORY} \
    RUN_LOCAL=${RUN_LOCAL} \
    TEST_CASE_RUN=${TEST_CASE_RUN} \
    ACTIONS_RUNNER_DEBUG=${ACTIONS_RUNNER_DEBUG} \
    DISABLE_ERRORS=${DISABLE_ERRORS}

#############################
# Copy scripts to container #
#############################
COPY lib /action/lib

##################################
# Copy linter rules to container #
##################################
COPY TEMPLATES /action/lib/.automation

######################
# Set the entrypoint #
######################
ENTRYPOINT ["/action/lib/linter.sh"]
