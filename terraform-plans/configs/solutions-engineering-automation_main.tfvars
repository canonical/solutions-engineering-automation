repository             = "solutions-engineering-automation"
repository_description = "Repo for automating tasks for Solutions Engineering Team."
branch                 = "main"
templates = {
  codeowners = {
    source      = "./templates/github/CODEOWNERS.tftpl"
    destination = ".github/CODEOWNERS"
    vars        = {}
  }
}
