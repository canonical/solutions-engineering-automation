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

# Generate a unique string to append to the branch name
resource "random_string" "update_uid" {
  length  = 8
  numeric = true
  special = false
}

# Flatten the repository and file information into a single list of maps based on the workflow_files variable
locals {
  repo_files = flatten([
    for file_key, file_info in var.workflow_files : {
      file = file_info.destination
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
    for file_key, file_info in var.workflow_files : file_info.destination =>
      try(data.github_repository_file.files["${file_info.destination}"].content, "")
  }
}

# Compare the fetched content with the local content to create a map of changed files
locals {
  changed_files = {
    for file_key, file_info in var.workflow_files : file_key => file_info
      if file(file_info.source) != local.repository_files_content[file_info.destination]
  }
}

# Create a new branch only if there are changed files
resource "github_branch" "workflows_branch" {
  count = length(local.changed_files) > 0 ? 1 : 0

  repository    = var.repository
  branch        = "${var.pr_branch}-${random_string.update_uid.id}"
  source_branch = var.branch
}

# Create or update files in the repository only if they have changed
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

# Create a pull request only if there are changed files
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
  value = length(local.changed_files) > 0 ? true : false
}

# Output the PR branch if PR was created
output "pr_branch" {
  value = length(local.changed_files) > 0 ? github_repository_pull_request.workflows_update_pr[0].head_ref : "No PR created"

  depends_on = [
    github_repository_pull_request.workflows_update_pr
  ]
}
