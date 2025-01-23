repository             = "prometheus-hardware-exporter"
repository_description = "Prometheus Hardware Exporter is an exporter for Hardware Observer"
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
    vars        = {}
  }
}
