variable "queues" {
  type = map(object({
    fifo_queue                  = optional(bool)
    content_based_deduplication = optional(bool)
    receive_wait_time_seconds   = optional(number)
    visibility_timeout_seconds  = optional(number)
    message_max_age             = optional(number)
    message_max_size            = optional(number)
  }))
}

variable "creds" {
  type = map(object({
    can_manage  = bool
    can_receive = bool
    can_publish = bool
  }))
}
