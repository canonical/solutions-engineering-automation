module "github_settings" {
  source                 = "./modules/GitHub/settings"
  owner                  = var.owner
  repository             = var.repository
  repository_description = var.repository_description
  branch                 = var.branch
}

module "github_templates" {
  source         = "./modules/GitHub/templates"
  owner          = var.owner
  repository     = var.repository
  branch         = var.branch
  templates      = var.templates
}

output "repository" {
  value = module.github_templates.repository
}

output "branch" {
  value = module.github_templates.branch
}

output "pr_branch" {
  value = module.github_templates.pr_branch
}

output "pr_created" {
  value = module.github_templates.pr_created
}

output "pr_url" {
  value = module.github_templates.pr_url
}

output "changed_files" {
  value = module.github_templates.changed_files
}
