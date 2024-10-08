repository             = "charm-prometheus-blackbox-exporter"
repository_description = "This charm provides the Prometheus Blackbox exporter, part of the Prometheus monitoring system"
branch                 = "main"
templates = {
  gitignore = {
    source      = "./templates/github/gitignore.tftpl"
    destination = ".gitignore"
    vars   = {}
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
      component  = "blackbox-exporter",
      epic_key   = "SOLENG-46"
    }
  }
}
