repository             = "charm-logrotated"
repository_description = "logrotate is a subordinate charm that ensure that all logrotate.d configurations within /etc/logrotate.d/ folder are modified accordingly to a retention period defined in the charm"
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
  check = {
    source      = "./templates/github/charm_check.yaml.tftpl"
    destination = ".github/workflows/check.yaml"
    vars        = {
      runs_on = "[[ubuntu-22.04]]",
      test_commands = "['tox -e func']",
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
