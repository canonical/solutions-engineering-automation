repository = "hardware-observer-operator"
branch     = "main"
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
    variables   = {
      branch = "main"
    }
  }
}
