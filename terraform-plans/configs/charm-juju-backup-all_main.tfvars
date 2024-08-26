repository             = "charm-juju-backup-all"
repository_description = "Juju Backup All - a charm to perform Juju and database backups"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
