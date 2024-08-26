repository             = "charm-kubernetes-service-checks"
repository_description = "This charm provides Kubernetes Service checks for Nagios"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
