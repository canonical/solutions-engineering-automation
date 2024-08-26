repository             = "charmed-openstack-exporter-snap"
repository_description = "Snap package for the OpenStack exporter"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
