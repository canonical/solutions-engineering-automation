repository             = "charm-prometheus-juju-exporter"
repository_description = "Charm that deploys exporter, publishing statistics about juju-deployed machines"
branch                 = "main"
templates = {
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
  # Temporarily disable it since the charm uses a different template
  # check = {
  #   source      = "./templates/github/charm_check.yaml.tftpl"
  #   destination = ".github/workflows/check.yaml"
  #   vars = {
  #     runs_on       = "[[ubuntu-22.04]]",
  #     test_commands = "['TEST_JUJU3=1 make functional']",
  #     juju_channels = "[\"3.4/stable\", \"3.5/stable\"]",
  #   }
  # }
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
      component = "juju-exporter",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "charm-prometheus-juju-exporter"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.toml"
    vars = {
      coverage_threshold_percent = "100"
    }
  }
}
