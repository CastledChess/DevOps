variable "name" {
  type = string
}

variable "node_type" {
  type = string
}

variable "engine" {
  type = string
}

variable "is_ha_cluster" {
  type    = bool
  default = false
}

variable "disable_backup" {
  type    = bool
  default = false
}

variable "database_name" {
  type    = string
  default = null
}

variable "database_names" {
  type    = list(string)
  default = []
}

variable "admin_creds_secret" {
  type = object({
    host_key_name     = optional(string, "DB_HOST")
    port_key_name     = optional(string, "DB_PORT")
    user_key_name     = optional(string, "DB_USERNAME")
    password_key_name = optional(string, "DB_PASSWORD")
  })
  default = {
    host_key_name     = "DB_HOST"
    port_key_name     = "DB_PORT"
    user_key_name     = "DB_USERNAME"
    password_key_name = "DB_PASSWORD"
  }
  # https://stackoverflow.com/a/71150801
  # https://github.com/hashicorp/terraform/issues/24142
  nullable = false
}

variable "users" {
  type = map(object({
    permissions = map(string)
    is_admin    = optional(bool, false)

    creds_secret = optional(object({
      host_key_name     = optional(string, "DB_HOST")
      port_key_name     = optional(string, "DB_PORT")
      user_key_name     = optional(string, "DB_USERNAME")
      password_key_name = optional(string, "DB_PASSWORD")
      }), {
      host_key_name     = "DB_HOST"
      port_key_name     = "DB_PORT"
      user_key_name     = "DB_USERNAME"
      password_key_name = "DB_PASSWORD"
    })
  }))
  default = {}
}

variable "init_settings" {
  type    = map(string)
  default = null
}

variable "settings" {
  type    = map(string)
  default = null
}

variable "volume_type" {
  type    = string
  default = "lssd"
}

variable "volume_size_in_gb" {
  type    = string
  default = null
}

variable "backup_schedule_frequency" {
  type    = number
  default = null
}

variable "backup_schedule_retention" {
  type    = number
  default = null
}

variable "backup_same_region" {
  type    = bool
  default = true
}

variable "is_public" {
  type    = bool
  default = false
}

variable "private_networks" {
  type    = list(string)
  default = []
}
