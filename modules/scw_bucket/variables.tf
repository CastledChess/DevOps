variable "name" {
  type        = string
  description = "The name of the bucket"
}

variable "acl" {
  type        = string
  description = "The canned ACL you want to apply to the bucket"
  default     = "private"
}

variable "region" {
  type        = string
  description = "The region in which the bucket should be created"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to set to the bucket"
  default     = {}
}

variable "lifecycle_rules" {
  type = map(object({
    prefix     = optional(string, "")
    enabled    = optional(bool, true)
    expiration = optional(object({ days = string }))
    transition = optional(object({ days = string, storage_class = string }))
  }))
  default = {}
}
