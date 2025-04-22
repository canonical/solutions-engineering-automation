repository             = "charm-nrpe"
repository_description = "A subordinate charm used to configure nrpe (Nagios Remote Plugin Executor)"
branch                 = "main"
templates = {
  contributing = {
    source      = "./templates/github/CONTRIBUTING.md.tftpl"
    destination = "CONTRIBUTING.md"
    vars        = {}
  }
  gitignore = {
    source      = "./templates/github/gitignore.tftpl"
    destination = ".gitignore"
    vars        = {}
  }
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
  check = {
    source      = "./templates/github/charm_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars = {
      # github hosted runners are amd64
      # Ubuntu_ARM64_4C_16G_01 is the github-hosted arm64 runner we have access to.
      # We prefer the github runners because they are smaller machines and save resources.
      # If we have issues with it, we can switch to the larger and more numerous self-hosted options:
      # - runs-on: [self-hosted, jammy, ARM64]
      #
      # Cannot test on s390x and ppc64el because setup-python action does not support s390x and ppc64el (see issue #206)
      tests_on           = "[[ubuntu-24.04], [Ubuntu_ARM64_4C_16G_01]]",
      builds_on          = "[[ubuntu-24.04], [Ubuntu_ARM64_4C_16G_01], [self-hosted, linux, s390x],[self-hosted, ppc64el]]",
      test_commands      = "['tox -e func']",
      juju_channels      = "[\"3.4/stable\"]",
      charmcraft_channel = "3.x/stable",
      python_versions    = "['3.8', '3.10']",
      # Temporary remove because of issue: https://warthogs.atlassian.net/browse/TICSISSUES-58
      # tics_project       = "charm-nrpe"
      tics_project = ""
    }
  }
  promote = {
    source      = "./templates/github/charm_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars = {
      charmcraft_channel = "3.x/stable",
    }
  }
  release = {
    source      = "./templates/github/charm_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars = {
      runs_on = "ubuntu-24.04",
    }
  }
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component = "nrpe",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "charm-nrpe"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.toml"
    vars = {
      coverage_threshold_percent = "50"
    }
  }
  tox = {
    source      = "./templates/github/tox.ini.tftpl"
    destination = "tox.ini"
    vars = {
      functest_type     = "zaza"
      unittest_type     = "pytest"
      is_python_project = "true"
      enable_pylint     = "false"
      enable_mypy       = "false"
    }
  }
}
