repository             = "charm-prometheus-libvirt-exporter"
repository_description = "A charm that provides per-domain metrics related to CPU, memory, disk and network usage using libvirt exporter."
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
  check = {
    source      = "./templates/github/charm_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars = {
      # github hosted runners are amd64
      # Ubuntu_ARM64_4C_16G_01 is the github-hosted arm64 runner we have access to.
      # We prefer the github runners because they are smaller machines and save resources.
      # If we have issues with it, we can switch to the larger and more numerous self-hosted options:
      # - runs-on: [self-hosted, jammy, ARM64]
      runs_on            = "[[ubuntu-22.04], [Ubuntu_ARM64_4C_16G_01]]",
      test_commands      = "['tox -e func']",
      juju_channels      = "[\"3.4/stable\"]",
      charmcraft_channel = "3.x/stable",
      python_versions    = "['3.8', '3.10']",
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
      component = "libvirt-exporter",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "charm-prometheus-libvirt-exporter"
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
