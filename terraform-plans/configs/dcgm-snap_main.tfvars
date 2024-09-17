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
    vars        = {
      runs_on = "[[ubuntu-22.04], [self-hosted, jammy, ARM64]]",
    }
  }
  promote = {
    source      = "./templates/github/snap_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars   = {}
  }
  release = {
    source      = "./templates/github/snap_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars        = {
       runs_on = "[[ubuntu-22.04], [self-hosted, jammy, ARM64]]",
    }
  }
  yamllint = {
    source      = "./templates/github/snap_yamllint.yaml.tftpl"
    destination = ".yamllint"
    vars        = {}
  }
}
