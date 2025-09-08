repository             = "charm-openstack-service-checks"
repository_description = "Collection of Nagios checks and other utilities that can be used to verify the operation of an OpenStack cluster"
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
      tests_on           = "[['self-hosted', 'jammy', 'amd64', 'two-xlarge']]",
      builds_on          = "[['self-hosted', 'jammy', 'amd64', 'two-xlarge']]",
      test_commands      = "[ \"TEST_MODEL_SETTINGS='update-status-hook-interval=30s' tox -e func -- --keep-model -b jammy-yoga\", \"TEST_MODEL_SETTINGS='update-status-hook-interval=30s' tox -e func -- --keep-model -b focal-yoga\" ]"
      juju_channels      = "['3.6/stable']",
      charmcraft_channel = "3.x/stable",
      python_versions    = "['3.8', '3.10']",
      tics_project       = "charm-openstack-service-checks"
    }
  }
  promote = {
    source      = "./templates/github/charm_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars = {
      charmcraft_channel = "2.x/stable",
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
      component = "openstack-service-checks",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "charm-openstack-service-checks"
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
  bug_report = {
    source      = "./templates/github/charm_bug_report.yaml.tftpl"
    destination = ".github/ISSUE_TEMPLATE/bug_report.yaml"
    vars        = {}
  }
}
