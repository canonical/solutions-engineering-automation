repository             = "smartctl-exporter-snap"
repository_description = "Snap package for smartctl_exporter"
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
      python_versions = "['3.10']",
      # Cannot test on s390x and ppc64el because setup-python action does not support s390x and ppc64el (see issue #206)
      tests_on     = "[[ubuntu-24.04], [self-hosted, jammy, ARM64]]",
      builds_on    = "[[ubuntu-24.04], [self-hosted, jammy, ARM64], [self-hosted, linux, s390x],[self-hosted, ppc64el]]",
      tics_project = "smartctl-exporter-snap"
      needs_juju   = ""
    }
  }
  promote = {
    source      = "./templates/github/snap_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars = {
      promote_options = "['latest/edge -> latest/candidate', 'latest/candidate -> latest/stable']"
    }
  }
  release = {
    source      = "./templates/github/snap_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars = {
      runs_on  = "[[ubuntu-24.04], [self-hosted, jammy, ARM64], [self-hosted, ppc64el]]",
      channels = "latest/edge"
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
      component = "smartctl-exporter",
      epic_key  = "SOLENG-190"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "smartctl-exporter-snap"
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
      is_python_project = "true"
      enable_pylint     = "false"
      enable_mypy       = "false"
    }
  }
  bug_report = {
    source      = "./templates/github/snap_bug_report.yaml.tftpl"
    destination = ".github/ISSUE_TEMPLATE/bug_report.yaml"
  }
}
