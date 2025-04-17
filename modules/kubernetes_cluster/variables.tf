variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "type" {
  type    = string
  default = "kapsule"
}

variable "k8s_version" {
  type = string
}

variable "cni" {
  type = string
}

variable "private_network_id" {
  type    = string
  default = null
}

variable "autoscaler_config" {
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

variable "auto_upgrade" {
  type = object({
    enable                        = optional(bool)
    maintenance_window_start_hour = optional(number)
    maintenance_window_day        = optional(string)
  })
  default = null
}

variable "delete_additional_resources" {
  type    = bool
  default = false
}

variable "pools" {
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

variable "security_group_inbound_rules" {
  type = list(object({
    ip_range = string
    port     = number
  }))
  default = []
}
