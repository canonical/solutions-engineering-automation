repository             = "hardware-observer-operator"
branch                 = "main"
repository_description = "A charm to setup prometheus exporter for IPMI, RedFish and RAID devices from different vendors."
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
      runs_on       = "[[ubuntu-22.04], [Ubuntu_ARM64_4C_16G_01]]",
      test_commands = "['tox -e func -- -v --base ubuntu@20.04 --keep-models', 'tox -e func -- -v --base ubuntu@22.04 --keep-models', 'if [ \"$(uname -m)\" = \"aarch64\" ]; then echo \"skipping func tests on ubuntu@24.04/arm64\"; else tox -e func -- -v --base ubuntu@24.04 --keep-models; fi' ]",
      juju_channels = "[\"3.4/stable\"]",
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
      runs_on            = "ubuntu-24.04",
      charmcraft_channel = "3.x/stable",
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
}
