variable "scw_project_name" {
  type    = string
  default = null
}

variable "secret_store_enabled" {
  type    = bool
  default = false
}

variable "allowed_namespaces" {
  type    = list(string)
  default = ["external-secrets"]
}
