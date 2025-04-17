variable "monitoring_folder" {
  type        = string
  description = "Name of the folder to create"
}

variable "email_contacts" {
  type        = list(string)
  description = "Email contacts to alert in case of error"
  default = [
    "victor@keltio.fr",
    "kevin@keltio.fr",
  ]
}

variable "slack_channel" {
  type        = string
  description = "Slack channel to send alerts to"
  default     = "#021-tech-alerts"
}

variable "slack_webhook_url" {
  type        = string
  description = "Slack webhook url to use to send alerts"
}
