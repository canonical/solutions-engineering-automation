repository             = "charmed-openstack-upgrader"
repository_description = "Automatic upgrade tool for Charmed Openstack"
branch                 = "main"
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
      branch = "main"
    }
  }
}
