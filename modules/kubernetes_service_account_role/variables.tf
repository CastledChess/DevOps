variable "name" {
  type    = string
  default = null
}

variable "namespace" {
  type    = string
  default = null
}

variable "rules" {
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
  default = []
}
