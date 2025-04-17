variable "project_names" {
  type        = list(string)
  description = "List of project names to be created and managed within the Scaleway organization"
  default     = ["prod", "staging"]
}

variable "should_create_developer_access_app" {
  type    = bool
  default = true
}

variable "iam_groups" {
  type = map(object({
    tags        = optional(map(string), {})
    description = optional(string, "")
    policies = optional(list(object({
      permission_set = string
      scope_type     = string
      project_scope  = optional(list(string), [])
    })), [])
  }))
  default = {}
}

variable "iam_users" {
  type    = map(list(string))
  default = {}
}
