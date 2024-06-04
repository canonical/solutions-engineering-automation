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

variable "workflow_files" {
  type = map(object({
    source      = string
    destination = string
    variables   = map(string)
  }))
  description = "GitHub workflow file. The source is the file path of the template file."
}
