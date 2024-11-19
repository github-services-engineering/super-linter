# Inspired by https://github.com/jessfraz/dotfiles

.PHONY: all
all: info docker test ## Run all targets.

.PHONY: test
test: info validate-container-image-labels docker-build-check docker-dev-container-build-check test-lib inspec lint-codebase fix-codebase test-default-config-files test-actions-runner-debug test-actions-steps-debug test-runner-debug test-find lint-subset-files test-custom-ssl-cert test-non-default-workdir test-git-flags test-non-default-home-directory test-git-initial-commit test-git-merge-commit-push test-git-merge-commit-push-tag test-log-level test-use-find-and-ignore-gitignored-files test-linters-expect-failure-log-level-notice test-bash-exec-library-expect-success test-bash-exec-library-expect-failure test-save-super-linter-output test-save-super-linter-output-custom-path test-save-super-linter-custom-summary test-custom-gitleaks-log-level test-dont-save-super-linter-log-file test-dont-save-super-linter-output test-linters test-linters-fix-mode ## Run the test suite

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: help
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: inspec-check
inspec-check: ## Validate inspec profiles
	docker run $(DOCKER_FLAGS) \
		--rm \
		-v "$(CURDIR)":/workspace \
		-w="/workspace" \
		chef/inspec check \
		--chef-license=accept \
		test/inspec/super-linter

SUPER_LINTER_TEST_CONTAINER_NAME := "super-linter-test"
SUPER_LINTER_TEST_CONTAINER_URL := $(CONTAINER_IMAGE_ID)
DOCKERFILE := ''
IMAGE := $(CONTAINER_IMAGE_TARGET)

# Default to stadard
ifeq ($(IMAGE),)
IMAGE := "standard"
endif

# Default to latest
ifeq ($(SUPER_LINTER_TEST_CONTAINER_URL),)
SUPER_LINTER_TEST_CONTAINER_URL := "ghcr.io/super-linter/super-linter:latest"
endif

ifeq ($(BUILD_DATE),)
BUILD_DATE := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
endif

ifeq ($(BUILD_REVISION),)
BUILD_REVISION := $(shell git rev-parse HEAD)
endif

ifeq ($(BUILD_VERSION),)
BUILD_VERSION := $(shell git rev-parse HEAD)
endif

ifeq ($(FROM_INTERVAL_COMMITLINT),)
FROM_INTERVAL_COMMITLINT := "HEAD~1"
endif

ifeq ($(TO_INTERVAL_COMMITLINT),)
TO_INTERVAL_COMMITLINT := "HEAD"
endif

GITHUB_TOKEN_PATH := "$(CURDIR)/.github-personal-access-token"

ifeq ($(GITHUB_TOKEN),)
GITHUB_TOKEN="$(shell cat "${GITHUB_TOKEN_PATH}")"
endif

DEV_CONTAINER_URL := "super-linter/dev-container:latest"

ifeq ($(GITHUB_HEAD_REF),)
RELEASE_PLEASE_TARGET_BRANCH := "$(shell git branch --show-current)"
else
RELEASE_PLEASE_TARGET_BRANCH := "${GITHUB_HEAD_REF}"
endif

.PHONY: info
info: ## Gather information about the runtime environment
	echo "whoami: $$(whoami)"; \
	echo "pwd: $$(pwd)"; \
	echo "IMAGE:" $(IMAGE); \
	echo "Build date: ${BUILD_DATE}"; \
	echo "Build revision: ${BUILD_REVISION}"; \
	echo "Build version: ${BUILD_VERSION}"; \
	echo "SUPER_LINTER_TEST_CONTAINER_URL:" $(SUPER_LINTER_TEST_CONTAINER_URL); \
	echo "ls -ahl: $$(ls -ahl)"; \
	docker images; \
	docker ps; \
	echo "Container image layers size:"; \
	docker history \
		--human \
		--no-trunc \
		--format "{{.Size}} {{.CreatedSince}} {{.CreatedBy}}" \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		| sort --human

.PHONY: check-github-token
check-github-token:
	@if [ ! -f "${GITHUB_TOKEN_PATH}" ]; then echo "Cannot find the file to load the GitHub access token: $(GITHUB_TOKEN_PATH). Create a readable file there, and populate it with a GitHub personal access token."; exit 1; fi

.PHONY: inspec
inspec: inspec-check ## Run InSpec tests
	DOCKER_CONTAINER_STATE="$$(docker inspect --format "{{.State.Running}}" $(SUPER_LINTER_TEST_CONTAINER_NAME) 2>/dev/null || echo "")"; \
	if [ "$$DOCKER_CONTAINER_STATE" = "true" ]; then docker kill $(SUPER_LINTER_TEST_CONTAINER_NAME); fi && \
	docker tag $(SUPER_LINTER_TEST_CONTAINER_URL) $(SUPER_LINTER_TEST_CONTAINER_NAME) && \
	SUPER_LINTER_TEST_CONTAINER_ID="$$(docker run -d --name $(SUPER_LINTER_TEST_CONTAINER_NAME) --rm -it --entrypoint /bin/ash $(SUPER_LINTER_TEST_CONTAINER_NAME) -c "while true; do sleep 1; done")" \
	&& docker run $(DOCKER_FLAGS) \
		--rm \
		-v "$(CURDIR)":/workspace \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e IMAGE=$(IMAGE) \
		-w="/workspace" \
		chef/inspec exec test/inspec/super-linter \
		--chef-license=accept \
		--diagnose \
		--log-level=debug \
		-t "docker://$${SUPER_LINTER_TEST_CONTAINER_ID}" \
	&& docker ps \
	&& docker kill $(SUPER_LINTER_TEST_CONTAINER_NAME)

.PHONY: docker
docker: docker-build-check check-github-token ## Build the container image
	DOCKER_BUILDKIT=1 docker buildx build --load \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg BUILD_REVISION=$(BUILD_REVISION) \
		--build-arg BUILD_VERSION=$(BUILD_VERSION) \
		--secret id=GITHUB_TOKEN,src=$(GITHUB_TOKEN_PATH) \
		--target $(IMAGE) \
		-t $(SUPER_LINTER_TEST_CONTAINER_URL) .

.PHONY: docker-build-check ## Run Docker build checks against the Super-linter image
docker-build-check:
	DOCKER_BUILDKIT=1 docker buildx build --check \
	.

.PHONY: docker-pull
docker-pull: ## Pull the container image from registry
	docker pull $(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: open-shell-super-linter-container
open-shell-super-linter-container: ## Open a shell in the Super-linter container
	docker run $(DOCKER_FLAGS) \
		--interactive \
		--entrypoint /bin/bash \
		--rm \
		-v "$(CURDIR)":/tmp/lint \
		-v "$(CURDIR)/dependencies/Gemfile.lock":/Gemfile.lock \
		-v "$(CURDIR)/dependencies/Gemfile":/Gemfile \
		-v "$(CURDIR)/dependencies/package-lock.json":/package-lock.json \
		-v "$(CURDIR)/dependencies/package.json":/package.json \
		-v "$(CURDIR)/dependencies/composer/composer.json":/php-composer/composer.json \
		-v "$(CURDIR)/dependencies/composer/composer.lock":/php-composer/composer.lock \
		-v "$(CURDIR)/scripts/bash-exec.sh":/usr/bin/bash-exec \
		-v "$(CURDIR)/scripts/git-merge-conflict-markers.sh":/usr/bin/git-merge-conflict-markers \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: validate-container-image-labels
validate-container-image-labels: ## Validate container image labels
	$(CURDIR)/test/validate-docker-labels.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		$(BUILD_DATE) \
		$(BUILD_REVISION) \
		$(BUILD_VERSION)

# For some cases, mount a directory that doesn't have too many files to keep tests short

.PHONY: test-actions-runner-debug
test-actions-runner-debug: ## Run super-linter with ACTIONS_RUNNER_DEBUG=true
	docker run \
		-e ACTIONS_RUNNER_DEBUG=true \
		-e RUN_LOCAL=true \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e USE_FIND_ALGORITHM=true \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v "$(CURDIR)/.github":/tmp/lint/.github \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-actions-steps-debug
test-actions-steps-debug: ## Run super-linter with ACTIONS_STEPS_DEBUG=true
	docker run \
		-e ACTIONS_STEPS_DEBUG=true \
		-e RUN_LOCAL=true \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e USE_FIND_ALGORITHM=true \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v "$(CURDIR)/.github":/tmp/lint/.github \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-runner-debug
test-runner-debug: ## Run super-linter with RUNNER_DEBUG=1
	docker run \
		-e RUNNER_DEBUG=1 \
		-e RUN_LOCAL=true \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e USE_FIND_ALGORITHM=true \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v "$(CURDIR)/.github":/tmp/lint/.github \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-find
test-find: ## Run super-linter on a subdirectory with USE_FIND_ALGORITHM=true
	docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e USE_FIND_ALGORITHM=true \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v "$(CURDIR)/.github":/tmp/lint/.github \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

# We need to set USE_FIND_ALGORITHM=true because the DEFALUT_WORKSPACE is not
# a Git directory in this test case
.PHONY: test-non-default-workdir
test-non-default-workdir: ## Run super-linter with DEFAULT_WORKSPACE set
	docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e DEFAULT_WORKSPACE=/tmp/not-default-workspace \
		-e USE_FIND_ALGORITHM=true \
		-e VALIDATE_ALL_CODEBASE=true \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v $(CURDIR)/.github:/tmp/not-default-workspace/.github \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-git-flags
test-git-flags: ## Run super-linter with different git-related flags
	docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e FILTER_REGEX_EXCLUDE=".*(/test/linters/|CHANGELOG.md).*" \
		-e DEFAULT_BRANCH=main \
		-e IGNORE_GENERATED_FILES=true \
		-e IGNORE_GITIGNORED_FILES=true \
		-e VALIDATE_ALL_CODEBASE=true \
		-e VALIDATE_JAVASCRIPT_STANDARD=false \
		-v "$(CURDIR)":/tmp/lint \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: lint-codebase
lint-codebase: ## Lint the entire codebase
	docker run $(DOCKER_FLAGS) \
		-e CREATE_LOG_FILE=true \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e DEFAULT_BRANCH=main \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e FILTER_REGEX_EXCLUDE=".*(/test/linters/|CHANGELOG.md).*" \
		-e GITLEAKS_CONFIG_FILE=".gitleaks-ignore-tests.toml" \
		-e RENOVATE_SHAREABLE_CONFIG_PRESET_FILE_NAMES="default.json,hoge.json" \
		-e SAVE_SUPER_LINTER_OUTPUT=true \
		-e SAVE_SUPER_LINTER_SUMMARY=true \
		-e VALIDATE_ALL_CODEBASE=true \
		-e VALIDATE_JAVASCRIPT_STANDARD=false \
		-v "$(CURDIR):/tmp/lint" \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

# Return an error if there are changes to commit
.PHONY: fix-codebase
fix-codebase: ## Fix and format the entire codebase
	docker run $(DOCKER_FLAGS) \
		-e CREATE_LOG_FILE=true \
		-e DEFAULT_BRANCH=main \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e FILTER_REGEX_EXCLUDE=".*(/test/linters/|CHANGELOG.md).*" \
		-e FIX_ENV=true \
		-e FIX_JAVASCRIPT_ES=true \
		-e FIX_JAVASCRIPT_PRETTIER=true \
		-e FIX_JSON=true \
		-e FIX_JSON_PRETTIER=true \
		-e FIX_MARKDOWN=true \
		-e FIX_MARKDOWN_PRETTIER=true \
		-e FIX_NATURAL_LANGUAGE=true \
		-e FIX_SHELL_SHFMT=true \
		-e FIX_YAML_PRETTIER=true \
		-e GITLEAKS_CONFIG_FILE=".gitleaks-ignore-tests.toml" \
		-e LOG_LEVEL=DEBUG \
		-e RUN_LOCAL=true \
		-e SAVE_SUPER_LINTER_OUTPUT=true \
		-e SAVE_SUPER_LINTER_SUMMARY=true \
		-e VALIDATE_ALL_CODEBASE=true \
		-e VALIDATE_JAVASCRIPT_STANDARD=false \
		-v "$(CURDIR):/tmp/lint" \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
	&& /bin/bash -c "source test/testUtils.sh; if ! CheckUnexpectedGitChanges ${CURDIR}; then exit 1; fi"


# This is a smoke test to check how much time it takes to lint only a small
# subset of files, compared to linting the whole codebase.
.PHONY: lint-subset-files
lint-subset-files: lint-subset-files-enable-only-one-type lint-subset-files-enable-expensive-io-checks

.PHONY: lint-subset-files-enable-only-one-type
lint-subset-files-enable-only-one-type: ## Lint a small subset of files in the codebase by enabling only one linter
	time docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e DEFAULT_BRANCH=main \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e FILTER_REGEX_EXCLUDE=".*(/test/linters/|CHANGELOG.md).*" \
		-e VALIDATE_ALL_CODEBASE=true \
		-e VALIDATE_MARKDOWN=true \
		-v "$(CURDIR):/tmp/lint" \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: lint-subset-files-enable-expensive-io-checks
lint-subset-files-enable-expensive-io-checks: ## Lint a small subset of files in the codebase and keep expensive I/O operations to check file types enabled
	time docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e DEFAULT_BRANCH=main \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e FILTER_REGEX_EXCLUDE=".*(/test/linters/|CHANGELOG.md).*" \
		-e VALIDATE_ALL_CODEBASE=true \
		-e VALIDATE_ARM=true \
		-e VALIDATE_CLOUDFORMATION=true \
		-e VALIDATE_KUBERNETES_KUBECONFORM=true \
		-e VALIDATE_MARKDOWN=true \
		-e VALIDATE_OPENAPI=true \
		-e VALIDATE_STATES=true \
		-e VALIDATE_TEKTON=true \
		-v "$(CURDIR):/tmp/lint" \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-lib
test-lib: test-globals-languages test-linter-rules test-build-file-list test-detect-files test-github-event test-setup-ssh test-validation test-output test-linter-commands test-linter-versions ## Test super-linter libs and globals

.PHONY: test-globals-languages
test-globals-languages: ## Test globals/languages.sh
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/globalsLanguagesTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-globals-linter-command-options
test-globals-linter-command-options: ## Test globals/LinterCommandsOptions.sh
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/globalsLinterCommandsOptionsTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-linter-rules
test-linter-rules: ## Test linterRules.sh
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/linterRulesTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-build-file-list
test-build-file-list: ## Test buildFileList
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/buildFileListTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-detect-files
test-detect-files: ## Test detectFiles
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/detectFilesTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-github-event
test-github-event: ## Test githubEvent
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/githubEventTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-setup-ssh
test-setup-ssh: ## Test setupSSH
	@docker run \
		-e GITHUB_TOKEN=${GITHUB_TOKEN} \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/setupSSHTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-validation
test-validation: ## Test validation
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/validationTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-output
test-output: ## Test output
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/outputTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-linter-commands
test-linter-commands: ## Test linterCommands
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/linterCommandsTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-linter-versions
test-linter-versions: ## Test linterVersions
	docker run \
		-v "$(CURDIR):/tmp/lint" \
		-w /tmp/lint \
		--entrypoint /tmp/lint/test/lib/linterVersionsTest.sh \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

# Run this test against a small directory because we're only interested in
# loading default configuration files. The directory that we run super-linter
# against should not be .github because that includes default linter rules.
# Disable commitlint because the workspace is not a Git repository.
.PHONY: test-default-config-files
test-default-config-files: ## Test default configuration files loading
	docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e USE_FIND_ALGORITHM=true \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v "$(CURDIR)/docs":/tmp/lint \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-custom-ssl-cert
test-custom-ssl-cert: ## Test the configuration of a custom SSL/TLS certificate
	docker run \
		-e RUN_LOCAL=true \
		-e LOG_LEVEL=DEBUG \
		-e ENABLE_GITHUB_ACTIONS_GROUP_TITLE=true \
		-e DEFAULT_BRANCH=main \
		-e USE_FIND_ALGORITHM=true \
		-e SSL_CERT_SECRET="$(shell cat test/data/ssl-certificate/rootCA-test.crt)" \
		-e VALIDATE_GIT_COMMITLINT=false \
		-v "$(CURDIR)/docs":/tmp/lint \
		--rm \
		$(SUPER_LINTER_TEST_CONTAINER_URL)

.PHONY: test-non-default-home-directory
test-non-default-home-directory: ## Test a non-default HOME directory
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_non_default_home" \
		"$(IMAGE)"

.PHONY: test-linters-fix-mode
test-linters-fix-mode: ## Run the linters test suite (fix mode)
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_fix_mode" \
		"$(IMAGE)"

.PHONY: test-linters
test-linters: test-linters-expect-success test-linters-expect-failure ## Run the linters test suite

.PHONY: test-linters-expect-success
test-linters-expect-success: ## Run the linters test suite expecting successes
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_expect_success" \
		"$(IMAGE)"

.PHONY: test-linters-expect-failure
test-linters-expect-failure: ## Run the linters test suite expecting failures
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_expect_failure" \
		"$(IMAGE)"

.PHONY: test-log-level
test-log-level: ## Run a test to check if there are conflicts with the LOG_LEVEL variable
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_log_level" \
		"$(IMAGE)"

.PHONY: test-linters-expect-failure-log-level-notice
test-linters-expect-failure-log-level-notice: ## Run the linters test suite expecting failures with a LOG_LEVEL set to NOTICE
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_expect_failure_notice_log" \
		"$(IMAGE)"

.PHONY: test-bash-exec-library-expect-success
test-bash-exec-library-expect-success: ## Run the linters test cases for BASH_EXEC expecting successes with BASH_EXEC_IGNORE_LIBRARIES set to true
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_bash_exec_library_expect_success" \
		"$(IMAGE)"

.PHONY: test-bash-exec-library-expect-failure
test-bash-exec-library-expect-failure: ## Run the linters test cases for BASH_EXEC expecting failures with BASH_EXEC_IGNORE_LIBRARIES set to true
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_bash_exec_library_expect_failure" \
		"$(IMAGE)"

.PHONY: test-git-initial-commit
test-git-initial-commit: ## Run super-linter against a repository that only has one commit
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_git_initial_commit" \
		"$(IMAGE)"

.PHONY: test-git-merge-commit-push
test-git-merge-commit-push: ## Run super-linter against a repository that has merge commits on a push event
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_merge_commit_push" \
		"$(IMAGE)"

.PHONY: test-git-merge-commit-push-tag
test-git-merge-commit-push-tag: ## Run super-linter against a repository that has merge commits and pushed a tag
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_merge_commit_push_tag" \
		"$(IMAGE)"

.PHONY: test-use-find-and-ignore-gitignored-files
test-use-find-and-ignore-gitignored-files: ## Run super-linter with USE_FIND_ALGORITHM=true and IGNORE_GITIGNORED_FILES=true
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_use_find_and_ignore_gitignored_files" \
		"$(IMAGE)"

.PHONY: test-save-super-linter-output
test-save-super-linter-output: ## Run super-linter with SAVE_SUPER_LINTER_OUTPUT=true
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_save_super_linter_output" \
		"$(IMAGE)"

.PHONY: test-save-super-linter-output-custom-path
test-save-super-linter-output-custom-path: ## Run super-linter with SAVE_SUPER_LINTER_OUTPUT=true and save output in a custom directory
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_cases_save_super_linter_output_custom_path" \
		"$(IMAGE)"

.PHONY: test-save-super-linter-custom-summary
test-save-super-linter-custom-summary: ## Run super-linter with a custom SUPER_LINTER_SUMMARY_FILE_NAME
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_custom_summary" \
		"$(IMAGE)"

.PHONY: test-custom-gitleaks-log-level
test-custom-gitleaks-log-level: ## Run super-linter with a custom Gitleaks log level
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_gitleaks_custom_log_level" \
		"$(IMAGE)"

.PHONY: test-dont-save-super-linter-log-file
test-dont-save-super-linter-log-file: ## Run super-linter without saving the Super-linter log file
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_dont_save_super_linter_log_file" \
		"$(IMAGE)"

.PHONY: test-dont-save-super-linter-output
test-dont-save-super-linter-output: ## Run super-linter without saving Super-linter output files
	$(CURDIR)/test/run-super-linter-tests.sh \
		$(SUPER_LINTER_TEST_CONTAINER_URL) \
		"run_test_case_dont_save_super_linter_output" \
		"$(IMAGE)"

.PHONY: docker-dev-container-build-check ## Run Docker build checks against the dev-container image
docker-dev-container-build-check:
	DOCKER_BUILDKIT=1 docker buildx build --check \
	"${CURDIR}/dev-dependencies"

.PHONY: build-dev-container-image
build-dev-container-image: docker-dev-container-build-check ## Build commit linter container image
	DOCKER_BUILDKIT=1 docker buildx build --load \
		--build-arg GID=$(shell id -g) \
		--build-arg UID=$(shell id -u) \
		-t ${DEV_CONTAINER_URL} "${CURDIR}/dev-dependencies"

.PHONY: release-please-dry-run
release-please-dry-run: build-dev-container-image check-github-token ## Run release-please in dry-run mode to preview the release pull request
	@echo "Running release-please against branch: ${RELEASE_PLEASE_TARGET_BRANCH}"; \
	docker run \
		-v "$(CURDIR):/source-repository" \
		--rm \
		${DEV_CONTAINER_URL} \
		release-please \
		release-pr \
		--config-file .github/release-please/release-please-config.json \
		--dry-run \
		--manifest-file .github/release-please/.release-please-manifest.json \
		--repo-url super-linter/super-linter \
		--target-branch ${RELEASE_PLEASE_TARGET_BRANCH} \
		--token "${GITHUB_TOKEN}" \
		--trace

.PHONY: open-shell-dev-container
open-shell-dev-container: build-dev-container-image ## Open a shell in the dev tools container
	docker run $(DOCKER_FLAGS) \
		--interactive \
		--entrypoint /bin/bash \
		--rm \
		-v "$(CURDIR)/dev-dependencies/package-lock.json":/package-lock.json \
		-v "$(CURDIR)/dev-dependencies/package.json":/package.json \
		$(DEV_CONTAINER_URL)
