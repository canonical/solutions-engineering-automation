repository             = "openstack-exporter-operator"
repository_description = "The openstack-exporter-operator is a machine charm for openstack-exporter."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
