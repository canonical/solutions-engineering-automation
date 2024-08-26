repository             = "charm-cloudsupport"
repository_description = "Support charm for OpenStack operations. It's main purpose is to package common tasks into easy-to-use actions."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
