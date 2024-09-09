repository             = "dcgm-snap"
repository_description = "Snap package for NVIDIA DCGM and DCGM exporter"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars   = {}
  }
  check = {
    source      = "./templates/github/snap_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars        = {}
  }
  promote = {
    source      = "./templates/github/snap_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars   = {}
  }
  release = {
    source      = "./templates/github/snap_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars        = {}
  }
}
