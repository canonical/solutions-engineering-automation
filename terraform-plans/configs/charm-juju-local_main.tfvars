repository             = "charm-juju-local"
repository_description = "This charm will deploy, configure and bootstrap lxd and juju for use with a local provider."
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
      runs_on       = "[[ubuntu-22.04]]",
      test_commands = "['tox -e func']",
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
      runs_on            = "[[ubuntu-22.04]]",
      charmcraft_channel = "2.x/stable",
    }
  }
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component = "juju-local",
      epic_key  = "SOLENG-46"
    }
  }
}
