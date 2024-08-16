repository             = "prometheus-openstack-exporter"
repository_description = "OpenStack exporter for the prometheus monitoring system"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
