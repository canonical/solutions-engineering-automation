repository             = "charm-kubernetes-service-checks"
repository_description = "This charm provides Kubernetes Service checks for Nagios"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
  check = {
    source      = "./templates/github/charm_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars        = {
      runs_on = "[[self-hosted, linux, x64, large, jammy]]",
      test_commands = "['make functional']",
    }
  }
  promote = {
    source      = "./templates/github/charm_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars        = {}
  }
  release = {
    source      = "./templates/github/charm_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars        = {
      runs_on = "[[ubuntu-latest]]",
    }
  }
}
