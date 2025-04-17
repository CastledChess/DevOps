variable "namespace" {
  description = "Namespace in the Kubernetes cluster"
  type        = string
  default     = ""
}

variable "cron_schedule" {
  description = "Cron schedule for the AWS Nuke CronJob"
  type        = string
  default     = ""
}

variable "aws_accounts" {
  description = "AWS accounts"
  type = map(object({
    account_id = string
    key_id     = string
    access_key = string
  }))
  default = {}
}
