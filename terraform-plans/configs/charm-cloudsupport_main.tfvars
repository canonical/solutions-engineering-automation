repository             = "charm-cloudsupport"
repository_description = "Support charm for OpenStack operations. It's main purpose is to package common tasks into easy-to-use actions."
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
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component = "cloudsupport",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "charm-cloudsupport"
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
