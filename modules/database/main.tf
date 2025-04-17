locals {
  database_names = [for db in concat(var.database_names, [var.database_name]) : db if db != null]
}

resource "scaleway_rdb_instance" "this" {
  name      = var.name
  node_type = var.node_type
  engine    = var.engine

  volume_type       = var.volume_type
  volume_size_in_gb = var.volume_size_in_gb

  is_ha_cluster = var.is_ha_cluster

  disable_backup            = var.disable_backup
  backup_schedule_frequency = var.backup_schedule_frequency
  backup_schedule_retention = var.backup_schedule_retention

  user_name = "admin_${random_password.admin_username.result}"
  password  = random_password.admin_password.result

  init_settings = var.init_settings
  settings      = var.settings

  dynamic "private_network" {
    for_each = var.private_networks
    content {
      pn_id       = private_network.value
      enable_ipam = true
    }
  }

  dynamic "load_balancer" {
    for_each = var.is_public ? { "darude" = "sandstorm" } : {}
    content {}
  }
}

resource "scaleway_rdb_database" "this" {
  for_each = toset(local.database_names)

  instance_id = scaleway_rdb_instance.this.id
  name        = each.key
}
