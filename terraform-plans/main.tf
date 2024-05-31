module "github_settings" {
  source                 = "./modules/GitHub/settings"
  owner                  = var.owner
  repository             = var.repository
  branch                 = var.branch
  force_push_bypassers   = ["${var.owner}/soleng-admin"]
  dismissal_restrictions = ["${var.owner}/soleng-admin", "${var.owner}/soleng-reviewers"]
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

output "changed_files" {
  value = module.github_workflow_files.changed_files
}
