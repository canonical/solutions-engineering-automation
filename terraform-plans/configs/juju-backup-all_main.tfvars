repository             = "juju-backup-all"
repository_description = "Tool for backing up charms, local juju configs, and juju controllers."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
