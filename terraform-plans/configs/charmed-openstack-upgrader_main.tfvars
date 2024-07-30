repository             = "charmed-openstack-upgrader"
repository_description = "Automatic upgrade tool for Charmed Openstack"
branch                 = "main"
workflow_files = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    variables   = {}
  }
  promote = {
    source      = "./templates/github/snap_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    variables   = {}
  }
  release = {
    source      = "./templates/github/snap_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    variables = {
      branch = "main"
    }
  }
}
