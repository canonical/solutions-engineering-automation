variable "owner" {
  type        = string
  description = "GitHub repository owner"
}

variable "repository" {
  type        = string
  description = "GitHub repository name"
}

variable "repository_description" {
  type        = string
  description = "GitHub repository description"
}

variable "branch" {
  type        = string
  description = "git branch name"
  default     = "main"
}

variable "templates" {
  type = map(object({
    # Path to the template file in this repository.
    source = string
    # Path to the target file in the target repository.
    destination = string
    # Variables used in the template,
    # expected to be variables as passed as the second argument to `templatefile()`.
    vars = any
  }))
  description = "Files to be templated into the target GitHub repository."
}

variable "pr_branch_prefix" {
  type        = string
  description = "Pull request branch name prefix."
  default     = "automation/update-managed-files"
}

variable "pr_body" {
  type        = string
  description = "Pull request body message."
  default     = "This is an automated pull request from https://github.com/canonical/solutions-engineering-automation to update centrally managed files."
}
