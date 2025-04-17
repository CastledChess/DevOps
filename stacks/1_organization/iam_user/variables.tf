variable "email" {
  type = string
}

variable "groups" {
  type    = list(string)
  default = []
}
