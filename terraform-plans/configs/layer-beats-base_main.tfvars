repository             = "layer-beats-base"
repository_description = "Base layer for Elastic Beats. This is a middle layer, and not designed to be self deployable"
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
      component  = "layer-beats-base",
      epic_key   = "SOLENG-46"
    }
  }
}
