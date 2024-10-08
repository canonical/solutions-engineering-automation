repository             = "prometheus-juju-exporter"
repository_description = "prometheus-juju-exporter snap collects machines' running status in all models under a Juju controller."
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
      component  = "juju-exporter",
      epic_key   = "SOLENG-46"
    }
  }
}
