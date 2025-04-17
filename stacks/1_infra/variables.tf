# VPC
variable "vpc_enabled" {
  type    = bool
  default = true
}

variable "vpc_name" {
  type    = string
  default = null
}

variable "vpc_tags" {
  type    = list(string)
  default = []
}

variable "vpc_timeouts" {
  type    = map(string)
  default = {}
}

variable "vpc_zones" {
  type    = list(string)
  default = []
}

variable "vpc_list_reservations" {
  type    = bool
  default = false
}

# PUBLIC GATEWAY
variable "vpc_public_gateway_name" {
  type    = string
  default = null
}

variable "vpc_public_gateway_type" {
  type    = string
  default = null
}

variable "vpc_public_gateway_bastion_enabled" {
  type    = bool
  default = true
}

# GATEWAY NETWORK
variable "vpc_gateway_network_cleanup_dhcp" {
  type    = bool
  default = true
}

variable "vpc_gateway_network_enable_masquerade" {
  type    = bool
  default = true
}

# GATEWAY IP REVERSE DNS
variable "vpc_reverse_dns_zone" {
  type    = string
  default = null
}

variable "vpc_gateway_reverse_dns" {
  type    = bool
  default = false
}

# PRIVATE NETWORK
variable "vpc_private_network_name" {
  type    = string
  default = null
}


# Database
variable "databases" {
  type    = any
  default = {}
}


## Redis
variable "redis" {
  type    = any
  default = {}
}


## Kubernetes
variable "kubernetes_enabled" {
  type    = bool
  default = true
}

variable "kubernetes_name" {
  type    = string
  default = null
}

variable "kubernetes_description" {
  type    = string
  default = null
}

variable "kubernetes_type" {
  type    = string
  default = null
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "kubernetes_cni" {
  type    = string
  default = null
}

variable "kubernetes_autoscaler_config" {
  type = object({
    disable_scale_down               = optional(bool)
    scale_down_delay_after_add       = optional(string)
    scale_down_unneeded_time         = optional(string)
    estimator                        = optional(string)
    expander                         = optional(string)
    ignore_daemonsets_utilization    = optional(bool)
    balance_similar_node_groups      = optional(bool)
    expendable_pods_priority_cutoff  = optional(number)
    scale_down_utilization_threshold = optional(number)
    max_graceful_termination_sec     = optional(number)
  })
  default = null
}

variable "kubernetes_auto_upgrade" {
  type = object({
    enable                        = optional(bool)
    maintenance_window_start_hour = optional(number)
    maintenance_window_day        = optional(string)
  })
  default = null
}

variable "kubernetes_delete_additional_resources" {
  type    = bool
  default = false
}

variable "kubernetes_pools" {
  type = map(object({
    name      = string
    node_type = string
    size      = string
    min_size  = optional(number)
    max_size  = optional(number)

    placement_group_id = optional(string)
    autoscaling        = optional(bool)
    autohealing        = optional(bool)
    container_runtime  = optional(string)
    kubelet_args       = optional(map(string))
    upgrade_policy = optional(object({
      max_surge       = optional(number)
      max_unavailable = optional(number)
    }))
    root_volume_type       = optional(string)
    root_volume_size_in_gb = optional(number)
    public_ip_disabled     = optional(bool)
    tags                   = optional(list(string), [])
  }))
  default = {}
}

variable "sqs" {
  type = object({
    queues = map(object({
      fifo_queue                  = optional(bool)
      content_based_deduplication = optional(bool)
      receive_wait_time_seconds   = optional(number)
      visibility_timeout_seconds  = optional(number)
      message_max_age             = optional(number)
      message_max_size            = optional(number)
    }))

    creds = map(object({
      can_manage  = bool
      can_receive = bool
      can_publish = bool
    }))
  })
  default = null
}

variable "kubernetes_security_group_inbound_rules" {
  type = list(object({
    ip_range = string
    port     = number
  }))
  default = []
}


## Buckets

variable "buckets" {
  type = map(object({
    acl    = optional(string)
    region = optional(string)
    tags   = optional(map(string))
  }))
  default = {}
}


## Cockpit

variable "cockpit_enabled" {
  type    = bool
  default = false
}

variable "cockpit_recipients" {
  type    = list(string)
  default = []
}
