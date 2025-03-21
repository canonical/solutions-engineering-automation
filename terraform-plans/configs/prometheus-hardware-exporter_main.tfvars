repository             = "prometheus-hardware-exporter"
repository_description = "Prometheus Hardware Exporter is an exporter for Hardware Observer"
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
      repository = "prometheus-hardware-exporter"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.toml"
    vars = {
      coverage_threshold_percent = "100"
    }
  }
  # Temporarily disable it since the package uses a different template
  # check = {
  #   source      = "./templates/github/charm_check.yaml.tftpl"
  #   destination = ".github/workflows/check.yaml"
  #   vars = {
  #     runs_on       = "[[ubuntu-22.04]]",
  #     test_commands = "['tox -e func']",
  #     juju_channels = "[\"3.4/stable\"]",
  #   }
  # }
  tox = {
    source      = "./templates/github/tox.ini.tftpl"
    destination = "tox.ini"
    vars = {
      functest_type = "pytest"
      unittest_type = "pytest"
    }
  }
  # this python package does not need a release template
}
