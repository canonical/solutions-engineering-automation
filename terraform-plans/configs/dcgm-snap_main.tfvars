repository             = "dcgm-snap"
repository_description = "Snap package for NVIDIA DCGM and DCGM exporter"
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
    source      = "./templates/github/snap_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars = {
      tests_on        = "[[ubuntu-24.04], [self-hosted, jammy, ARM64]]",
      builds_on       = "[[ubuntu-24.04], [self-hosted, jammy, ARM64]]",
      python_versions = "['3.10']",
      tics_project    = "dcgm-snap"
      needs_juju      = ""
    }
  }
  promote = {
    source      = "./templates/github/snap_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars = {
      promote_options = "['latest/edge -> latest/candidate', 'latest/candidate -> latest/stable', 'core24/edge -> core24/candidate', 'core24/candidate -> core24/stable']"
    }
  }
  release = {
    source      = "./templates/github/snap_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars = {
      runs_on  = "[[ubuntu-24.04], [self-hosted, jammy, ARM64]]",
      channels = "core24/edge,latest/edge"
    }
  }
  yamllint = {
    source      = "./templates/github/snap_yamllint.yaml.tftpl"
    destination = ".yamllint"
    vars        = {}
  }
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component = "dcgm",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "dcgm-snap"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.toml"
    vars = {
      coverage_threshold_percent = "0"
    }
  }
  tox = {
    source      = "./templates/github/tox.ini.tftpl"
    destination = "tox.ini"
    vars = {
      functest_type     = "pytest"
      unittest_type     = "none"
      is_python_project = "false"
      enable_pylint     = "false"
      enable_mypy       = "false"
    }
  }
}
