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
  app_auth {} # using environment variables for auth
}

resource "random_string" "update_uid" {
  length  = 8
  numeric = true
  special = false
}

locals {
  repo_files = flatten([
    for file_key, file_info in var.workflow_files : {
      file = file_info.destination
      source = file_info.source
    }
  ])
}

data "github_repository_file" "files" {
  for_each = {
    for item in local.repo_files : "${item.file}" => item
  }

  repository = var.repository
  file       = each.value.file
  branch     = var.branch
}

locals {
  repository_files_content = {
    for file_key, file_info in var.workflow_files : file_info.destination =>
      try(data.github_repository_file.files["${file_info.destination}"].content, "")
  }
}

locals {
  changed_files = {
    for file_key, file_info in var.workflow_files : file_key => file_info
      if file(file_info.source) != local.repository_files_content[file_info.destination]
  }
}

resource "github_branch" "workflows_branch" {
  count = length(local.changed_files) > 0 ? 1 : 0

  repository    = var.repository
  branch        = "${var.pr_branch}-${random_string.update_uid.id}"
  source_branch = var.branch
}

resource "github_repository_file" "workflows_files" {
  for_each = local.changed_files

  repository          = var.repository
  branch              = github_branch.workflows_branch[0].branch
  file                = each.value.destination
  content             = file(each.value.source)
  commit_message      = "update ${each.value.destination}"
  overwrite_on_create = true

  depends_on = [github_branch.workflows_branch]
}

resource "github_repository_pull_request" "workflows_update_pr" {
  count = length(local.changed_files) > 0 ? 1 : 0

  base_repository = var.repository
  base_ref        = var.branch
  head_ref        = github_branch.workflows_branch[0].branch
  title           = var.pr_title
  body            = var.pr_body

  depends_on = [
    github_branch.workflows_branch,
    github_repository_file.workflows_files
  ]
}

output "changed_files" {
  description = "Execute result: [repository, branch, changed_files]"
  value = [
      var.repository,
      var.branch,
      local.changed_files
  ]
}
