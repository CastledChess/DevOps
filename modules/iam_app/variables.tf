variable "project_name" {
  type        = string
  description = "Project to create app into (leave blank to use provider's)"
  default     = null
}

variable "name" {
  type        = string
  description = "IAM applications's name"
}

variable "policies" {
  type = list(object({
    policy_name            = string
    permission_set_names   = list(string)
    is_organization_policy = optional(bool, false)
  }))
  default     = []
  description = "IAM application's policies"
}

variable "create_api_key" {
  type        = bool
  default     = true
  description = "Create API key for IAM application"
  nullable    = false
}
