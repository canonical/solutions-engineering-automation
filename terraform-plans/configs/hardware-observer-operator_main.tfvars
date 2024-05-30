repository             = "hardware-observer-operator"
branch                 = "main"
repository_description = "A charm to setup prometheus exporter for IPMI, RedFish and RAID devices from different vendors."
workflow_files = {
  codeowners = {
    source      = "./files/github/CODEOWNERS"
    destination = ".github/CODEOWNERS"
    variables   = {}
  }
  promote = {
    source      = "./files/github/charm_promote.yaml"
    destination = ".github/workflows/promote.yaml"
    variables   = {}
  }
  release = {
    source      = "./files/github/charm_release.yaml"
    destination = ".github/workflows/release.yaml"
    variables = {
      branch = "main"
    }
  }
}
