repository             = "hardware-observer-operator"
branch                 = "main"
repository_description = "A charm to setup prometheus exporter for IPMI, RedFish and RAID devices from different vendors."
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
      runs_on = "[[ubuntu-22.04], [Ubuntu_ARM64_4C_16G_01]]",
      test_commands = "['tox -e func -- -v --series focal --keep-model', 'tox -e func -- -v --series jammy --keep-model']",
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
      runs_on = "[[ubuntu-22.04], [Ubuntu_ARM64_4C_16G_01]]",
    }
  }
}
