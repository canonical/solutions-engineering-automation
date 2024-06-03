repository = "charmed-openstack-upgrader"
branch     = "3.x"
workflow_files = {
  codeowners = {
    source      = "./files/github/CODEOWNERS"
    destination = ".github/CODEOWNERS"
    variables   = {}
  }
  promote = {
    source      = "./files/github/snap_promote.yaml"
    destination = ".github/workflows/promote.yaml"
    variables   = {}
  }
  release = {
    source      = "./files/github/snap_release.yaml"
    destination = ".github/workflows/release.yaml"
    variables = {
      branch = "3.x"
    }
  }
}
