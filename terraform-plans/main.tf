module "github_settings" {
  source                 = "./modules/GitHub/settings"
  owner                  = var.owner
  repository             = var.repository
  repository_description = var.repository_description
  branch                 = var.branch
  pull_request_bypassers = ["${var.owner}/soleng-admin"]
}

module "github_workflow_files" {
  source         = "./modules/GitHub/workflows"
  owner          = var.owner
  repository     = var.repository
  branch         = var.branch
  workflow_files = var.workflow_files
}

output "repository" {
  value = module.github_workflow_files.repository
}

output "branch" {
  value = module.github_workflow_files.branch
}

output "pr_branch" {
  value = module.github_workflow_files.pr_branch
}

output "pr_created" {
  value = module.github_workflow_files.pr_created
}

output "pr_url" {
  value = module.github_workflow_files.pr_url
}

output "changed_files" {
  value = module.github_workflow_files.changed_files
}
