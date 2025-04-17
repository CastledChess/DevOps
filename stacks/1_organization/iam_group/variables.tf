variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "description" {
  type    = string
  default = ""
}

variable "policies" {
  type = list(object({
    permission_set = string
    scope_type     = string
    project_scope  = optional(list(string), [])
  }))
  default = []
}
