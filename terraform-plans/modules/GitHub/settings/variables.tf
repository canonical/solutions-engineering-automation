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

variable "repository_homepage_url" {
  type        = string
  description = "GitHub repository homepage url (used for linking to charmhub pages, etc.)"
  default     = ""
}

variable "branch" {
  type        = string
  description = "Branch name"
  default     = "main"
}
