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
  description = "Branch name"
  default     = "main"
}

variable "force_push_bypassers" {
  type        = list(any)
  description = "List of user / groups  that are allowed to bypass force push restrictions."
}

variable "dismissal_restrictions" {
  type        = list(any)
  description = "List of user / groups with dismissal access."
}

variable "pull_request_bypassers" {
  type        = list(any)
  description = "List of user / groups that are allowed to bypass pull request requirements."
}
