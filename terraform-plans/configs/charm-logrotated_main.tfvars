repository             = "charm-logrotated"
repository_description = "logrotate is a subordinate charm that ensure that all logrotate.d configurations within /etc/logrotate.d/ folder are modified accordingly to a retention period defined in the charm"
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
}
