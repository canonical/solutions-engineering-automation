repository             = "charm-userdir-ldap"
repository_description = "A charm to install and configured userdir-ldap"
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
    vars        = {}
  }
  check = {
    source      = "./templates/github/charm_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars        = {
      # github hosted runners are amd64
      # Ubuntu_ARM64_4C_16G_01 is the github-hosted arm64 runner we have access to.
      # We prefer the github runners because they are smaller machines and save resources.
      # If we have issues with it, we can switch to the larger and more numerous self-hosted options:
      # - runs-on: [self-hosted, jammy, ARM64]
      runs_on = "[[ubuntu-22.04], [Ubuntu_ARM64_4C_16G_01]]",
      test_commands = "['make functional']",
    }
  }
  promote = {
    source      = "./templates/github/charm_promote.yaml.tftpl"
    destination = ".github/workflows/promote.yaml"
    vars        = {}
  }
  release = {
    source      = "./templates/github/charm_release.yaml.tftpl"
    destination = ".github/workflows/release.yaml"
    vars        = {
      runs_on = "[[ubuntu-22.04]]",
    }
  }
}
