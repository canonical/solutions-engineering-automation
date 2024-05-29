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

resource "github_repository" "repo" {
  name = var.repository

  has_issues      = true
  has_projects    = false
  has_wiki        = false
  has_discussions = false

  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
  allow_auto_merge   = false

  allow_update_branch    = true
  delete_branch_on_merge = false

}

data "github_team" "admins" {
  slug = "soleng-admin"
}

data "github_team" "reviewers" {
  slug = "soleng-reviewers"
}

data "github_team" "engineering" {
  slug = "solutions-engineering"
}

resource "github_repository_collaborators" "repo_collaborators" {
  repository = var.repository

  team {
    permission = "admin"
    team_id    = data.github_team.admins.id
  }

  team {
    permission = "maintain"
    team_id    = data.github_team.reviewers.id
  }

  team {
    permission = "push"
    team_id    = data.github_team.engineering.id
  }
}

resource "github_branch_protection" "branch_protection" {
  repository_id                   = github_repository.repo.node_id
  pattern                         = var.branch
  enforce_admins                  = true
  require_signed_commits          = true
  required_linear_history         = true
  require_conversation_resolution = true
  allows_deletions                = false

  allows_force_pushes  = false
  force_push_bypassers = var.force_push_bypassers

  required_status_checks {
    strict = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    dismissal_restrictions          = var.dismissal_restrictions
    pull_request_bypassers          = var.pull_request_bypassers
    require_code_owner_reviews      = true
    required_approving_review_count = 2
  }
}
