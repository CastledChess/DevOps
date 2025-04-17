resource "scaleway_k8s_cluster" "this" {
  name                        = var.name
  description                 = var.description
  version                     = var.k8s_version
  cni                         = var.cni
  type                        = var.type
  delete_additional_resources = var.delete_additional_resources
  private_network_id          = var.private_network_id

  autoscaler_config {
    disable_scale_down               = can(var.autoscaler_config.disable_scale_down) ? var.autoscaler_config.disable_scale_down : null
    scale_down_delay_after_add       = can(var.autoscaler_config.scale_down_delay_after_add) ? var.autoscaler_config.scale_down_delay_after_add : null
    scale_down_unneeded_time         = can(var.autoscaler_config.scale_down_unneeded_time) ? var.autoscaler_config.disable_scale_down : null
    estimator                        = can(var.autoscaler_config.estimator) ? var.autoscaler_config.estimator : null
    expander                         = can(var.autoscaler_config.expander) ? var.autoscaler_config.expander : null
    ignore_daemonsets_utilization    = can(var.autoscaler_config.ignore_daemonsets_utilization) ? var.autoscaler_config.ignore_daemonsets_utilization : null
    balance_similar_node_groups      = can(var.autoscaler_config.balance_similar_node_groups) ? var.autoscaler_config.balance_similar_node_groups : null
    expendable_pods_priority_cutoff  = can(var.autoscaler_config.expendable_pods_priority_cutoff) ? var.autoscaler_config.expendable_pods_priority_cutoff : null
    scale_down_utilization_threshold = can(var.autoscaler_config.scale_down_utilization_threshold) ? var.autoscaler_config.scale_down_utilization_threshold : null
    max_graceful_termination_sec     = can(var.autoscaler_config.max_graceful_termination_sec) ? var.autoscaler_config.max_graceful_termination_sec : null
  }

  dynamic "auto_upgrade" {
    for_each = var.auto_upgrade != null ? [var.auto_upgrade] : []

    content {
      enable                        = can(var.auto_upgrade.enable) ? var.auto_upgrade.enable : false
      maintenance_window_start_hour = can(var.auto_upgrade.maintenance_window_start_hour) ? var.auto_upgrade.maintenance_window_start_hour : 0
      maintenance_window_day        = can(var.auto_upgrade.maintenance_window_day) ? var.auto_upgrade.maintenance_window_day : "any"
    }
  }
}

resource "scaleway_k8s_pool" "this" {
  for_each = var.pools

  cluster_id = scaleway_k8s_cluster.this.id
  name       = each.value.name
  node_type  = each.value.node_type
  size       = each.value.size

  min_size = can(each.value.min_size) ? each.value.min_size : null
  max_size = can(each.value.max_size) ? each.value.max_size : null

  placement_group_id = can(each.value.placement_group_id) ? each.value.placement_group_id : null
  autoscaling        = can(each.value.autoscaling) ? each.value.autoscaling : null
  autohealing        = can(each.value.autohealing) ? each.value.autohealing : null
  container_runtime  = can(each.value.container_runtime) ? each.value.container_runtime : null
  kubelet_args       = can(each.value.kubelet_args) ? each.value.kubelet_args : null
  upgrade_policy {
    max_surge       = can(each.value.upgrade_policy.max_surge) ? each.value.upgrade_policy.max_surge : null
    max_unavailable = can(each.value.upgrade_policy.max_unavailable) ? each.value.upgrade_policy.max_unavailable : null
  }
  root_volume_type       = can(each.value.root_volume_type) ? each.value.root_volume_type : null
  root_volume_size_in_gb = can(each.value.root_volume_size_in_gb) ? each.value.root_volume_size_in_gb : null

  public_ip_disabled = can(each.value.public_ip_disabled) ? each.value.public_ip_disabled : null

  tags = can(each.value.tags) ? each.value.tags : []
}

# no easier way to get the security_group_id straight from the k8s_cluster as the resource is created by Scaleway and not specifiable by Terraform
locals { cluster_id = replace(scaleway_k8s_cluster.this.id, "${scaleway_k8s_cluster.this.region}/", "") }
data "scaleway_instance_security_group" "this" { name = "kubernetes ${local.cluster_id}" }

resource "scaleway_instance_security_group_rules" "this" {
  security_group_id = data.scaleway_instance_security_group.this.id

  dynamic "inbound_rule" {
    for_each = var.security_group_inbound_rules
    content {
      action   = "accept"
      ip_range = inbound_rule.value.ip_range
      port     = inbound_rule.value.port
    }
  }
}
