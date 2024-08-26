repository             = "prometheus-hardware-exporter"
repository_description = "Prometheus Hardware Exporter is an exporter for Hardware Observer"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
