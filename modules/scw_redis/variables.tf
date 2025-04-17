variable "name" {
  type = string
}

variable "redis_version" {
  type = string
}

variable "node_type" {
  type = string
}

variable "creds_secret" {
  type = object({
    host_key_name        = optional(string, "REDIS_HOST")
    user_key_name        = optional(string, "REDIS_USERNAME")
    password_key_name    = optional(string, "REDIS_PASSWORD")
    certificate_key_name = optional(string, "REDIS_CERT")
  })
  default = {
    host_key_name        = "REDIS_HOST"
    user_key_name        = "REDIS_USERNAME"
    password_key_name    = "REDIS_PASSWORD"
    certificate_key_name = "REDIS_CERT"
  }
  nullable = false
}

variable "cluster_size" {
  type    = number
  default = 1
  validation {
    condition     = var.cluster_size != 2
    error_message = "Cluster size can't be 2 (either 1 or 3+)"
  }
}

variable "tls_enabled" {
  type    = bool
  default = true
}

variable "acls" {
  type = list(object({
    ip          = string
    description = optional(string)
  }))
  default  = []
  nullable = false
}

variable "private_networks" {
  type     = list(string)
  default  = []
  nullable = false
}

variable "settings" {
  type     = object({})
  default  = {}
  nullable = false
}
