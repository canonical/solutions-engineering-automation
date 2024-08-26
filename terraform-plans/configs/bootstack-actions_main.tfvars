repository             = "bootstack-actions"
repository_description = "Actions for unifying lint, unit and functional tests, and charm and snap releases"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
