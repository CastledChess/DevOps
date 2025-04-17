## Database
variable "databases" {
  type = map(object({
    node_type      = string
    engine         = string
    is_ha_cluster  = string
    disable_backup = string
    db_name        = string
    db_names       = list(string)
    # admin_username = string
    # admin_password = string
    users = map(object({
      name        = string
      password    = string
      permissions = map(string)
    }))
    init_settings             = object({})
    settings                  = object({})
    volume_type               = string
    volume_size_in_gb         = number
    backup_schedule_frequency = number
    backup_schedule_retention = number
    backup_same_region        = bool
    private_networks          = list(string) # Ensure this is included
  }))
  default = {}
}

## Redis
variable "redis_clusters" {
  type = map(object({
    version          = string
    node_type        = string
    username         = string
    password         = string
    cluster_size     = number
    tls_enabled      = bool
    private_networks = list(string) # Add this line
  }))
  default = {}
}

## SQS
variable "sqs_queues" {
  type = map(object({
    fifo_queue                  = optional(bool)
    content_based_deduplication = optional(bool)
    receive_wait_time_seconds   = optional(number)
    visibility_timeout_seconds  = optional(number)
    message_max_age             = optional(number)
    message_max_size            = optional(number)
  }))
}

variable "sqs_creds" {
  type = map(object({
    can_manage  = bool
    can_receive = bool
    can_publish = bool
  }))
}

# Buckets
variable "buckets" {
  type = map(object({
    acl    = optional(string)
    region = optional(string)
    tags   = optional(map(string))
  }))
}
