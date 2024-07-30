repository             = "hardware-observer-operator"
branch                 = "main"
repository_description = "A charm to setup prometheus exporter for IPMI, RedFish and RAID devices from different vendors."
workflow_files = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    variables   = {}
  }
  promote = {
    source      = "./templates/github/charm_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    variables   = {}
  }
  release = {
    source      = "./templates/github/charm_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    variables = {
      branch = "main"
    }
  }
}
