repository              = "openstack-exporter-operator"
repository_description  = "The openstack-exporter-operator is a machine charm for openstack-exporter."
repository_homepage_url = "https://charmhub.io/openstack-exporter"
branch                  = "main"
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
      runs_on            = "[['self-hosted', 'jammy', 'amd64', 'two-xlarge']]",
      test_commands      = "['TEST_MODEL_SETTINGS=\"update-status-hook-interval=30s\" tox -e func']",
      juju_channels      = "['3.4/stable']",
      charmcraft_channel = "3.x/stable",
      python_versions    = "['3.10']",
      project            = "openstack-exporter-operator"
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
      component = "openstack-exporter",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "openstack-exporter-operator"
    }
  }
}
