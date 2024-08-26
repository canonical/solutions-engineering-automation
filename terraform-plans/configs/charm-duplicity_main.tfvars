repository             = "charm-duplicity"
repository_description = "A charm that provides functionality for both manual and automatic backups for a deployed application"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
