repository             = "dcgm-snap"
repository_description = "Snap package for NVIDIA DCGM and DCGM exporter"
branch                 = "main"
templates = {
  gitignore = {
    source      = "./templates/github/gitignore.tftpl"
    destination = ".gitignore"
    vars   = {}
  }
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
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component  = "dcgm",
      epic_key   = "SOLENG-46"
    }
  }
}
