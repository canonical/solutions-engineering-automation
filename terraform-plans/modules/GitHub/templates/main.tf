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
  app_auth {} # using environment variables for authentication
}

# Flatten the repository and file information into a single list of maps based on the templates variable
locals {
  repo_files = flatten([
    for file_key, file_info in var.templates : {
      file   = file_info.destination
      source = file_info.source
    }
  ])
}

# Fetch the current content of the files from the repository
data "github_repository_file" "files" {
  for_each = {
    for item in local.repo_files : "${item.file}" => item
  }

  repository = var.repository
  file       = each.value.file
  branch     = var.branch
}

# Store the fetched content in a local variable, defaulting to an empty string if the file does not exist
locals {
  repository_files_content = {
    for file_key, file_info in var.templates : file_info.destination =>
    try(data.github_repository_file.files["${file_info.destination}"].content, "")
  }
}

# Compare the fetched content with the local content to create a map of changed files
locals {
  changed_files = {
    for file_key, file_info in var.templates : file_key => file_info
    if templatefile(file_info.source, file_info.vars) != local.repository_files_content[file_info.destination]
  }
}

locals {
  pr_branch = var.branch == "main" ? var.pr_branch_prefix : "${var.pr_branch_prefix}-${var.branch}"
}

# Create a new branch only if there are changed files
resource "github_branch" "managed_files_branch" {
  count = length(local.changed_files) > 0 ? 1 : 0

  repository    = var.repository
  branch        = local.pr_branch
  source_branch = var.branch
}

# Create or update files in the repository only if they have changed
resource "github_repository_file" "managed_files" {
  for_each = local.changed_files

  repository          = var.repository
  branch              = github_branch.managed_files_branch[0].branch
  file                = each.value.destination
  content             = templatefile(each.value.source, each.value.vars)
  commit_message      = "update ${each.value.destination}"
  overwrite_on_create = true

  depends_on = [github_branch.managed_files_branch]
}

data "github_repository_pull_requests" "open" {
  base_repository = var.repository
  base_ref        = var.branch
  state           = "open"
}

locals {
    pr_exists = length([for pr in data.github_repository_pull_requests.open.results : pr if pr.head_ref == local.pr_branch]) > 0
}

locals {
    existing_pr = local.pr_exists ? [for pr in data.github_repository_pull_requests.open.results : pr if pr.head_ref == local.pr_branch][0] : null
}

locals {
    should_create_pr = length(local.changed_files) > 0 && !local.pr_exists
}

# Create a pull request only if there are changed files and there isn't already a PR open for the branch
resource "github_repository_pull_request" "managed_files_update_pr" {
  count = local.should_create_pr ? 1 : 0

  base_repository = var.repository
  base_ref        = var.branch
  head_ref        = github_branch.managed_files_branch[0].branch
  title           = var.pr_title
  body            = var.pr_body

  depends_on = [
    github_branch.managed_files_branch,
    github_repository_file.managed_files
  ]
}

# Outputs for debugging and verification
output "repository" {
  value = var.repository
}

output "branch" {
  value = var.branch
}

output "changed_files" {
  value = local.changed_files
}

# Output to indicate if PR was created
output "pr_created" {
  value = length(github_repository_pull_request.managed_files_update_pr) > 0 ? true : false
}

output "pr_branch" {
  value = local.pr_branch
}

output "pr_url" {
  value = (
    length(local.changed_files) > 0 ?
      (
        local.should_create_pr ?
          "https://github.com/${var.owner}/${var.repository}/pull/${github_repository_pull_request.managed_files_update_pr[0].number}" :
          "https://github.com/${var.owner}/${var.repository}/pull/${local.existing_pr.number}"
      ) :
      "No PR created"
  )

  depends_on = [
    github_repository_pull_request.managed_files_update_pr
  ]
}
