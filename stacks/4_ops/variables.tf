variable "k8s_ops_namespace" {
  type    = string
  default = "ops"
}

variable "pgadmin_enabled" {
  type    = bool
  default = false
}

variable "pgadmin_admin_email" {
  type    = string
  default = "admin@admin.com"
}

variable "pgadmin_enable_persistence" {
  type    = bool
  default = false
}

variable "phpmyadmin_enabled" {
  type    = bool
  default = false
}
