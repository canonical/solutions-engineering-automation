repository             = "charm-openstack-service-checks"
repository_description = "Collection of Nagios checks and other utilities that can be used to verify the operation of an OpenStack cluster"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
