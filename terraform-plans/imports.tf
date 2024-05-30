import {
  to = module.github_settings.github_repository.repo
  id = var.repository
}

import {
  to = module.github_settings.github_branch_protection.branch_protection
  id = "${var.repository}:${var.branch}"
}
