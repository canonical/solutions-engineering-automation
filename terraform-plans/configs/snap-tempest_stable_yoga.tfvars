repository             = "snap-tempest"
repository_description = "This repository contains the source code of the snap for the OpenStack integration test suite, Tempest."
branch                 = "stable/yoga"
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
      unittest_type     = "none"
      is_python_project = "false"
      enable_pylint     = "false"
      enable_mypy       = "false"
    }
  }
  # release is done by launchpad
  bug_report = {
    source      = "./templates/github/snap_bug_report.yaml.tftpl"
    destination = ".github/ISSUE_TEMPLATE/bug_report.yaml"
    vars        = {}
  }
}
