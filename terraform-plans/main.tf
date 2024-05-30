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
