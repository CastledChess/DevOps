variable "external_dns_enabled" {
  type    = bool
  default = true
}

variable "external_dns_set" {
  type    = map(string)
  default = {}
}
