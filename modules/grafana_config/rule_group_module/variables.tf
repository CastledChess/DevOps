variable "folder_uid" {
  type = string
}

variable "datasource_uid" {
  type = string
}

variable "rules" {
  type = list(object({
    name          = string
    summary       = string
    description   = string
    expression    = string
    dashboard_uid = optional(string)
    panel_id      = optional(string)
  }))
}
