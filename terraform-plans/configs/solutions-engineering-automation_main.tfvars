repository             = "solutions-engineering-automation"
repository_description = "Repo for automating tasks for Solutions Engineering Team."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component  = "software-engineering",
      epic_key   = "SOLENG-46"
    }
  }
}
