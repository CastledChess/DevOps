variable "name" {
  description = "Name of the secret to create"
  type        = string
}

variable "path" {
  description = "Path of the secret to create"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the secret to create"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags of the secret to create"
  type        = list(string)
  default     = null
}

variable "data" {
  description = "Data of the secret"
  type        = any
}
