repository             = "hardware-observer-operator"
branch                 = "main"
repository_description = "A charm to setup prometheus exporter for IPMI, RedFish and RAID devices from different vendors."
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
      # Cannot test on s390x and ppc64el because setup-python action does not support s390x and ppc64el (see issue #206)
      tests_on           = "[[ubuntu-24.04], [Ubuntu_ARM64_4C_16G_01]]",
      builds_on          = "[[ubuntu-24.04], [Ubuntu_ARM64_4C_16G_01], [self-hosted, linux, s390x],[self-hosted, ppc64el]]",
      test_commands      = "['tox -e func -- -v --base ubuntu@20.04 --keep-models', 'tox -e func -- -v --base ubuntu@22.04 --keep-models', 'tox -e func -- -v --base ubuntu@24.04 --keep-models' ]",
      juju_channels      = "[\"3.6/stable\"]",
      charmcraft_channel = "3.x/stable",
      python_versions    = "['3.8', '3.10', '3.12']",
      tics_project       = "hardware-observer-operator"
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
      component = "hardware-observer",
      epic_key  = "SOLENG-190"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "hardware-observer-operator"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.toml"
    vars = {
      coverage_threshold_percent = "100"
    }
  }
  tox = {
    source      = "./templates/github/tox.ini.tftpl"
    destination = "tox.ini"
    vars = {
      functest_type     = "pytest"
      unittest_type     = "pytest"
      is_python_project = "true"
      enable_pylint     = "false"
      enable_mypy       = "false"
    }
  }
}
