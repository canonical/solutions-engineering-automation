variable "owner" {
  type        = string
  description = "GitHub repository owner"
}

variable "repository" {
  type        = string
  description = "GitHub repository name."
}

variable "branch" {
  type        = string
  description = "Default branch name."
  default     = "main"
}

variable "pr_branch" {
  type        = string
  description = "Pull request branch name."
  default     = "chore/update-workflows"
}

variable "pr_title" {
  type        = string
  description = "Pull request title."
  default     = "Update workflow files"
}

variable "pr_body" {
  type        = string
  description = "Pull request body message."
  default     = "This is an automated pull request to update workflow files from https://github.com/canonical/solutions-engineering-automation."
}

variable "workflow_files" {
  type = map(object({
    source      = string
    destination = string
    variables   = map(string)
  }))
  description = "GitHub workflow file. The source is the file path of the template file."
}
