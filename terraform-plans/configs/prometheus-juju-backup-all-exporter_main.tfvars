repository             = "prometheus-juju-backup-all-exporter"
repository_description = "Prometheus exporter snap for charm-juju-backup-all"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
