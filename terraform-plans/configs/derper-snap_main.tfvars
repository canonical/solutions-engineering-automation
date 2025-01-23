repository             = "derper-snap"
repository_description = "A snap package for Tailscale's DERP server https://tailscale.com/kb/1118/custom-derp-servers"
branch                 = "main"
templates = {
  gitignore = {
    source      = "./templates/github/gitignore.tftpl"
    destination = ".gitignore"
    vars        = {}
  }
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
  check = {
    source      = "./templates/github/snap_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars = {
      runs_on = "[[ubuntu-22.04], [self-hosted, jammy, ARM64]]",
    }
  }
  promote = {
    source      = "./templates/github/snap_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars = {
      promote_options = "['latest/edge -> latest/candidate', 'latest/candidate -> latest/stable']"
    }
  }
  release = {
    source      = "./templates/github/snap_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars = {
      runs_on  = "[[ubuntu-22.04], [self-hosted, jammy, ARM64]]",
      channels = "latest/edge"
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
      component = "tailscale",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "derper-snap"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.tom"
    vars        = {}
  }
}
