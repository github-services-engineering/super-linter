# frozen_string_literal: true

# PUll in env vars passed
image = ENV["IMAGE"]

version_file_path = "/action/linterVersions.txt"

control "super-linter-environment-variables" do
  impact 1
  title "Super-Linter environment variables check"
  desc "Check that environment variables that Super-Linter needs are defined."

  describe os_env("VERSION_FILE") do
    its("content") { should eq version_file_path }
  end

  describe os_env("IMAGE") do
    its("content") { should match(/^(standard|slim)$/) }
  end

  describe os_env("RENOVATE_X_IGNORE_RE2") do
    its("content") { should eq "true" }
  end

  if (image == "standard")
    describe os_env("DOTNET_CLI_TELEMETRY_OPTOUT") do
      its("content") { should eq "1" }
    end
    describe os_env("POWERSHELL_TELEMETRY_OPTOUT") do
      its("content") { should eq "1" }
    end
  end
end

##################################################
# Check to see all system packages are installed #
##################################################
control "super-linter-installed-packages" do
  impact 1
  title "Super-Linter installed packages check"
  desc "Check that packages that Super-Linter needs are installed."

  packages = [
    "bash",
    "ca-certificates",
    "coreutils",
    "curl",
    "file",
    "gcompat",
    "git-lfs",
    "git",
    "go",
    "jq",
    "libxml2-utils",
    "nodejs-current",
    "npm",
    "openjdk17-jre",
    "openssh-client",
    "parallel",
    "perl",
    "php83",
    "php83-ctype",
    "php83-curl",
    "php83-dom",
    "php83-iconv",
    "php83-pecl-igbinary",
    "php83-intl",
    "php83-mbstring",
    "php83-openssl",
    "php83-phar",
    "php83-simplexml",
    "php83-tokenizer",
    "php83-xmlwriter",
    "R",
    "rakudo",
    "ruby",
    "rust-clippy",
    "rustfmt",
    "tar",
    "zef"
  ]

  # Removed linters from slim image
  SLIM_IMAGE_REMOVED_PACKAGES=%w(
    rust-clippy
    rustfmt
  )

  packages.each do |item|
    if (image == "slim" && SLIM_IMAGE_REMOVED_PACKAGES.include?(item))
      next
    else
      describe package(item) do
        it { should be_installed }
      end
    end
  end
end

control "super-linter-uninstalled-packages" do
  impact 1
  title "Super-Linter uninstalled packages check"
  desc "Check that packages that Super-Linter doesn't need are not installed."

  packages = [
    "cmake",
    "clang17-extra-tools",
    "g++",
    "gnupg",
    "libc-dev",
    "libxml2-dev",
    "linux-headers",
    "make",
    "perl-dev",
    "python3-dev",
    "R-dev",
    "R-doc",
    "readline-dev",
    "ruby-bundler",
    "ruby-dev",
    "ruby-rdoc"
  ]

  packages.each do |item|
    describe package(item) do
      it { should_not be_installed }
    end
  end
end

###########################################
# Check to see all binaries are installed #
###########################################
control "super-linter-installed-commands" do
  impact 1
  title "Super-Linter installed commands check"
  desc "Check that commands that Super-Linter needs are installed."

  default_version_option = "--version"
  default_version_expected_exit_status = 0
  default_expected_stdout_regex = /(.*?)/s

  linters = [
    { linter_name: "actionlint"},
    { linter_name: "ansible-lint", expected_stdout_regex: /(.*)/},
    { linter_name: "arm-ttk", version_command: "grep -iE 'version' '/usr/bin/arm-ttk' | xargs"},
    { linter_name: "asl-validator"},
    { linter_name: "bash-exec", expected_exit_status: 1}, # expect a return code = 1 because this linter doesn't support a "get linter version" command
    { linter_name: "biome"},
    { linter_name: "black"},
    { linter_name: "cfn-lint"},
    { linter_name: "checkov"},
    { linter_name: "checkstyle", version_command: "java -jar /usr/bin/checkstyle --version"},
    { linter_name: "chktex"},
    { linter_name: "clang-format"},
    { linter_name: "clippy", linter_command: "cargo clippy"},
    { linter_name: "clj-kondo"},
    { linter_name: "coffeelint"},
    { linter_name: "commitlint"},
    { linter_name: "composer"},
    { linter_name: "cpplint"},
    { linter_name: "dart"},
    { linter_name: "dotenv-linter"},
    { linter_name: "dotnet"},
    { linter_name: "editorconfig-checker", version_option: "-version"},
    { linter_name: "eslint"},
    { linter_name: "flake8"},
    { linter_name: "gherkin-lint", expected_exit_status: 1}, # expect a return code = 1 because this linter doesn't support a "get linter version" command
    { linter_name: "git-merge-conflict-markers"},
    { linter_name: "gitleaks", version_option: "version"},
    { linter_name: "golangci-lint"},
    { linter_name: "goreleaser"},
    { linter_name: "google-java-format", version_command: "java -jar /usr/bin/google-java-format --version"},
    { linter_name: "hadolint"},
    { linter_name: "helm", version_option: "version"}, # not used as linter, needed for checkov's helm framework
    { linter_name: "htmlhint"},
    { linter_name: "isort"},
    { linter_name: "jscpd"},
    { linter_name: "ktlint"},
    { linter_name: "kustomize", version_option: "version"}, # not used as linter, needed for checkov's kustomize checks
    { linter_name: "kubeconform", version_option: "-v"},
    { linter_name: "lua", version_option: "-v"},
    { linter_name: "markdownlint"},
    { linter_name: "mypy"},
    { linter_name: "npm-groovy-lint"},
    { linter_name: "perl"},
    { linter_name: "php"},
    { linter_name: "phpcs"},
    { linter_name: "phpstan"},
    { linter_name: "prettier"},
    { linter_name: "protolint", version_option: "version"},
    { linter_name: "psalm"},
    { linter_name: "pwsh"},
    { linter_name: "pyink"},
    { linter_name: "pylint"},
    { linter_name: "R", version_command: "R --slave -e \"r_ver <- R.Version()\\$version.string; \
            lintr_ver <- packageVersion('lintr'); \
            glue::glue('lintr { lintr_ver } on { r_ver }')\""},
    { linter_name: "raku", version_command: "raku --version | strings -n 8"},
    { linter_name: "renovate-config-validator", version_command: "renovate --version"},
    { linter_name: "rubocop"},
    { linter_name: "ruff"},
    { linter_name: "rustfmt"},
    { linter_name: "scalafmt"},
    { linter_name: "shellcheck"},
    { linter_name: "shfmt"},
    { linter_name: "snakefmt"},
    { linter_name: "snakemake"},
    { linter_name: "spectral"},
    { linter_name: "sqlfluff"},
    { linter_name: "standard"},
    { linter_name: "stylelint"},
    { linter_name: "tekton-lint"},
    { linter_name: "terraform"},
    { linter_name: "terragrunt"},
    { linter_name: "terrascan", version_option: "version"},
    { linter_name: "textlint"},
    { linter_name: "tflint"},
    { linter_name: "ts-standard"},
    { linter_name: "xmllint"},
    { linter_name: "yamllint"},
  ]

  # Removed linters from slim image
  SLIM_IMAGE_REMOVED_LINTERS=%w(
    arm-ttk
    clippy
    dotnet
    pwsh
    rustfmt
  )

  linters.each do |linter|
    # If we didn't specify a linter command, use the linter name as a linter
    # command because the vast majority of linters have name == command
    linter_command = ""

    if (image == "slim" && SLIM_IMAGE_REMOVED_LINTERS.include?(linter[:linter_name]))
      next
    else
      if (linter.key?(:linter_command))
        linter_command = linter[:linter_command]
      else
        linter_command = linter[:linter_name]
      end

      describe command("command -v #{linter_command}") do
        its("exit_status") { should eq 0 }
      end

      # A few linters have a command that it's different than linter_command
      if (linter.key?(:version_command))
        version_command = linter[:version_command]
      else
        # Check if the linter needs an option that is different from the one that
        # the vast majority of linters use to get the version
        if (linter.key?(:version_option))
          version_option = linter[:version_option]
        else
          version_option = default_version_option
        end

        version_command = "#{linter_command} #{version_option}"

        if (linter.key?(:expected_exit_status))
          expected_exit_status = linter[:expected_exit_status]
        else
          expected_exit_status = default_version_expected_exit_status
        end

        if (linter.key?(:expected_stdout_regex))
          expected_stdout_regex = linter[:expected_stdout_regex]
        else
          expected_stdout_regex = default_expected_stdout_regex
        end

        ##########################################################
        # Being able to run the command `linter --version` helps #
        # achieve that the linter is installed, ini PATH, and    #
        # has the libraries needed to be able to basically run   #
        ##########################################################
        describe command(version_command) do
          its("exit_status") { should eq expected_exit_status }
          its("stdout") { should match (expected_stdout_regex) }
        end
      end
    end
  end
end

###################################
# Linters with no version command #
# protolint editorconfig-checker  #
# bash-exec gherkin-lint          #
###################################

############################################
# Check to see all Ruby Gems are installed #
############################################
control "super-linter-installed-ruby-gems" do
  impact 1
  title "Super-Linter installed Ruby gems check"
  desc "Check that Ruby gems that Super-Linter needs are installed."

  gems = [
    "rubocop-capybara",
    "rubocop-factory_bot",
    "rubocop-github",
    "rubocop-minitest",
    "rubocop-performance",
    "rubocop-rails",
    "rubocop-rake",
    "rubocop-rspec_rails",
    "rubocop-rspec",
    "rubocop",
    "standard"
  ]

  gems.each do |item|
    describe gem(item) do
      it { should be_installed }
    end
  end
end

###############################################
# Check to see all NPM packages are installed #
###############################################
control "super-linter-installed-npm-packages" do
  impact 1
  title "Super-Linter installed NPM packages check"
  desc "Check that NPM packages that Super-Linter needs are installed."

  packages = [
    "@babel/eslint-parser",
    "@babel/preset-react",
    "@babel/preset-typescript",
    "@biomejs/biome",
    "@coffeelint/cli",
    "@ibm/tekton-lint",
    "@react-native/eslint-config",
    "@react-native/eslint-plugin",
    "@stoplight/spectral-cli",
    "@typescript-eslint/eslint-plugin",
    "@typescript-eslint/parser",
    "asl-validator",
    "commitlint",
    "eslint",
    "eslint-config-airbnb",
    "eslint-config-prettier",
    "eslint-plugin-jest",
    "eslint-plugin-json",
    "eslint-plugin-jsonc",
    "eslint-plugin-jsx-a11y",
    "eslint-plugin-prettier",
    "eslint-plugin-react",
    "eslint-plugin-react-hooks",
    "eslint-plugin-vue",
    "gherkin-lint",
    "htmlhint",
    "jscpd",
    "markdownlint-cli",
    "next",
    "next-pwa",
    "npm-groovy-lint",
    "postcss-less",
    "prettier",
    "prettyjson",
    "pug",
    "react",
    "react-dom",
    "react-intl",
    "react-redux",
    "react-router-dom",
    "renovate",
    "standard",
    "stylelint",
    "stylelint-config-recommended-scss",
    "stylelint-config-sass-guidelines",
    "stylelint-config-standard",
    "stylelint-config-standard-scss",
    "stylelint-prettier",
    "stylelint-scss",
    "textlint",
    "textlint-filter-rule-allowlist",
    "textlint-filter-rule-comments",
    "textlint-rule-terminology",
    "ts-standard",
    "typescript"
  ]

  packages.each do |item|
    describe npm(item, path: "/") do
      it { should be_installed }
    end
  end
end

###############################################
# Check to see if PyPi packages are installed #
###############################################
control "super-linter-installed-pypi-packages" do
  impact 1
  title "Super-Linter installed PyPi packages check"
  desc "Check that PyPi packages that Super-Linter needs are installed."

  pypi_packages = [
    "ansible-lint",
    "black",
    "cfn-lint",
    "checkov",
    "cpplint",
    "flake8",
    "isort",
    "mypy",
    "pyink",
    "pylint",
    "ruff",
    "snakefmt",
    "snakemake",
    "sqlfluff",
    "yamllint",
    "yq"
  ]

  pypi_packages.each do |item|
    describe pip(item, "/venvs/#{item}/bin/pip") do
      it { should be_installed }
    end
  end
end

#####################################
# Check to see if directories exist #
#####################################
control "super-linter-validate-directories" do
  impact 1
  title "Super-Linter check for directories"
  desc "Check that directories that Super-Linter needs are installed."

  dirs = [
    "/node_modules",
    "/action/lib",
    "/action/lib/functions",
    "/action/lib/.automation",
    "/root/.tflint.d/plugins/github.com/terraform-linters/tflint-ruleset-aws",
    "/root/.tflint.d/plugins/github.com/terraform-linters/tflint-ruleset-azurerm",
    "/root/.tflint.d/plugins/github.com/terraform-linters/tflint-ruleset-google",
    "/usr/local/lib/",
    "/usr/local/share/"
  ]

  # Removed linters from slim image
  SLIM_IMAGE_REMOVED_DIRS=%w(
  )

  dirs.each do |item|
    if (image == "slim" && SLIM_IMAGE_REMOVED_DIRS.include?(item))
      next
    else
      describe directory(item) do
        it { should exist }
        it { should be_directory }
      end
    end
  end
end

###############################
# Check to see if files exist #
###############################
control "super-linter-validate-files" do
  impact 1
  title "Super-Linter check for files"
  desc "Check that files that Super-Linter needs are installed."

  files = [
    "/action/lib/linter.sh",
    "/action/lib/functions/buildFileList.sh",
    "/action/lib/functions/detectFiles.sh",
    "/action/lib/functions/githubEvent.sh",
    "/action/lib/functions/linterCommands.sh",
    "/action/lib/functions/linterRules.sh",
    version_file_path,
    "/action/lib/functions/log.sh",
    "/action/lib/functions/output.sh",
    "/action/lib/functions/possum.sh",
    "/action/lib/functions/updateSSL.sh",
    "/action/lib/functions/validation.sh",
    "/action/lib/functions/worker.sh",
    "/action/lib/globals/languages.sh",
    "/action/lib/globals/linterCommandsOptions.sh",
    "/action/lib/globals/linterRules.sh",
    "/action/lib/.automation/actionlint.yml",
    "/action/lib/.automation/.ansible-lint.yml",
    "/action/lib/.automation/.arm-ttk.psd1",
    "/action/lib/.automation/.cfnlintrc.yml",
    "/action/lib/.automation/.checkov.yaml",
    "/action/lib/.automation/.chktexrc",
    "/action/lib/.automation/.clang-format",
    "/action/lib/.automation/.clj-kondo",
    "/action/lib/.automation/.coffee-lint.json",
    "/action/lib/.automation/.ecrc",
    "/action/lib/.automation/.eslintrc.yml",
    "/action/lib/.automation/.flake8",
    "/action/lib/.automation/.gherkin-lintrc",
    "/action/lib/.automation/.golangci.yml",
    "/action/lib/.automation/.groovylintrc.json",
    "/action/lib/.automation/.hadolint.yaml",
    "/action/lib/.automation/.htmlhintrc",
    "/action/lib/.automation/.isort.cfg",
    "/action/lib/.automation/.jscpd.json",
    "/action/lib/.automation/.lintr",
    "/action/lib/.automation/.luacheckrc",
    "/action/lib/.automation/.markdown-lint.yml",
    "/action/lib/.automation/.mypy.ini",
    "/action/lib/.automation/.openapirc.yml",
    "/action/lib/.automation/.perlcriticrc",
    "/action/lib/.automation/.powershell-psscriptanalyzer.psd1",
    "/action/lib/.automation/.protolintrc.yml",
    "/action/lib/.automation/.python-black",
    "/action/lib/.automation/.python-lint",
    "/action/lib/.automation/.python-pyink",
    "/action/lib/.automation/.ruby-lint.yml",
    "/action/lib/.automation/.ruff.toml",
    "/action/lib/.automation/.scalafmt.conf",
    "/action/lib/.automation/.shellcheckrc",
    "/action/lib/.automation/.snakefmt.toml",
    "/action/lib/.automation/.sqlfluff",
    "/action/lib/.automation/.stylelintrc.json",
    "/action/lib/.automation/.tflint.hcl",
    "/action/lib/.automation/.yaml-lint.yml",
    "/action/lib/.automation/biome.json",
    "/action/lib/.automation/phpcs.xml",
    "/action/lib/.automation/phpstan.neon",
    "/action/lib/.automation/psalm.xml",
    "/usr/bin/bash-exec",
    "/usr/bin/git-merge-conflict-markers",
    "/usr/bin/helm", # needed for checkov's helm framework
    "/usr/bin/kustomize", # needed for checkov's kustomize checks
  ]

  files.each do |item|
    describe file(item) do
      it { should exist }
    end
  end
end

###############################
# Validate powershell modules #
###############################
control "super-linter-validate-powershell-modules" do
  impact 1
  title "Super-Linter validate Powershell Modules"
  desc "Check that Powershell modules that Super-Linter needs are installed."

  if (image == "slim")
    next
  else
    describe command("pwsh -c \"(Get-Module -Name PSScriptAnalyzer -ListAvailable | Select-Object -First 1).Name\" 2>&1") do
      its("exit_status") { should eq 0 }
      its("stdout") { should eq "PSScriptAnalyzer\n" }
    end

    describe command("pwsh -c \"(Get-Command Invoke-ScriptAnalyzer | Select-Object -First 1).Name\" 2>&1") do
      its("exit_status") { should eq 0 }
      its("stdout") { should eq "Invoke-ScriptAnalyzer\n" }
    end
  end
end
