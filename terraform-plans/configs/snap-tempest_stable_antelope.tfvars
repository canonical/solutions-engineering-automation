repository             = "snap-tempest"
repository_description = "This repository contains the source code of the snap for the OpenStack integration test suite, Tempest."
branch                 = "stable/antelope"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
