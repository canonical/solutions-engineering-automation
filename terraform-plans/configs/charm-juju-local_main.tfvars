repository             = "charm-juju-local"
repository_description = "This charm will deploy, configure and bootstrap lxd and juju for use with a local provider."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
