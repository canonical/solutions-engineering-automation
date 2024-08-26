repository             = "charm-prometheus-juju-exporter"
repository_description = "Charm that deploys exporter, publishing statistics about juju-deployed machines"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
