variable "domain_name" {
  type    = string
  default = null
}

variable "exposed_to_internet" {
  type    = bool
  default = false
}

variable "sets" {
  type    = map(string)
  default = {}
}

variable "argocd_image_updater_enabled" {
  type    = bool
  default = true
}

variable "argocd_image_updater_sets" {
  type    = map(string)
  default = {}
}
