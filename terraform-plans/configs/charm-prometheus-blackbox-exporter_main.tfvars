repository             = "charm-prometheus-blackbox-exporter"
repository_description = "This charm provides the Prometheus Blackbox exporter, part of the Prometheus monitoring system"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
