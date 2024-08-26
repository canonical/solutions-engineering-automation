repository             = "prometheus-juju-exporter"
repository_description = "prometheus-juju-exporter snap collects machines' running status in all models under a Juju controller."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
