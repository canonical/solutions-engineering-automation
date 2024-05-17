variable "owner" {
  type        = string
  description = "GitHub repository owner"
}

variable "repository" {
  type        = string
  description = "GitHub repository name"
}

variable "branch" {
  type        = string
  description = "git branch name"
  default     = "main"
}

variable "workflow_files" {
  type = map(object({
    source      = string
    destination = string
  }))
  description = "GitHub workflow files"
}
