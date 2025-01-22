repository             = "charmed-openstack-exporter-snap"
repository_description = "Snap package for the OpenStack exporter"
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
  tics = {
    source      = "./templates/github/snap_tics.yaml.tftpl"
    destination = ".github/workflows/tics.yaml"
    vars = {
      project = "charmed-openstack-exporter-snap",
    }
  }
  jira_sync_config = {
    source      = "./templates/github/jira_sync_config.yaml.tftpl"
    destination = ".github/.jira_sync_config.yaml"
    vars = {
      component = "openstack-exporter",
      epic_key  = "SOLENG-46"
    }
  }
  security = {
    source      = "./templates/github/SECURITY.md.tftpl"
    destination = "SECURITY.md"
    vars = {
      repository = "charmed-openstack-exporter-snap"
    }
  }
  pyproject = {
    source      = "./templates/github/pyproject.toml.tftpl"
    destination = "pyproject.tom"
    vars = {
      coverage_source = "['.']"
      coverage_omit   = "['snap/**', 'setup.py']"
    }
  }
}
