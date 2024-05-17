terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.owner
  app_auth {} # using environmet variables for auth
}


resource "random_string" "update_uid" {
  length  = 8
  numeric = true
  special = false
}

resource "github_branch" "workflows_branch" {
  repository    = var.repository
  branch        = "${var.pr_branch}-${random_string.update_uid.id}"
  source_branch = var.branch
}

resource "github_repository_file" "workflows_files" {
  for_each            = var.workflow_files
  repository          = var.repository
  branch              = github_branch.workflows_branch.branch
  file                = each.value.destination
  content             = file(each.value.source)
  commit_message      = "update ${each.value.destination}"
  overwrite_on_create = true
}

resource "github_repository_pull_request" "workflows_update_pr" {
  base_repository = var.repository
  base_ref        = var.branch
  head_ref        = github_branch.workflows_branch.branch
  title           = var.pr_title
  body            = var.pr_body

  depends_on = [
    github_branch.workflows_branch,
    github_repository_file.workflows_files
  ]
}
