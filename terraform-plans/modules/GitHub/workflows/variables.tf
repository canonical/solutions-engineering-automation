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
  default     = "Updating workflows files"
}

variable "pr_body" {
  type        = string
  description = "Pull request body message."
  default     = "Updates workflows files by SolEng bot."
}

variable "workflow_files" {
  type = map(object({
    source      = string
    destination = string
  }))
  description = "GitHub workflow files"
}
