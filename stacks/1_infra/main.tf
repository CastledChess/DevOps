module "vpc" {
  count  = var.vpc_enabled ? 1 : 0
  source = "../../modules/vpc"

  name                              = var.vpc_name
  tags                              = var.vpc_tags
  timeouts                          = var.vpc_timeouts
  zones                             = var.vpc_zones
  list_reservations                 = var.vpc_list_reservations
  public_gateway_name               = var.vpc_public_gateway_name
  vpc_public_gateway_type           = var.vpc_public_gateway_type
  public_gateway_bastion_enabled    = var.vpc_public_gateway_bastion_enabled
  gateway_network_cleanup_dhcp      = var.vpc_gateway_network_cleanup_dhcp
  gateway_network_enable_masquerade = var.vpc_gateway_network_enable_masquerade
  reverse_dns_zone                  = var.vpc_reverse_dns_zone
  gateway_reverse_dns               = var.vpc_gateway_reverse_dns
  private_network_name              = var.vpc_private_network_name
}

module "database" {
  for_each = var.databases

  source = "../../modules/database"

  name      = try(each.value.name, null)
  node_type = try(each.value.node_type, null)
  engine    = try(each.value.engine, null)

  is_ha_cluster  = try(each.value.is_ha_cluster, null)
  disable_backup = try(each.value.disable_backup, null)

  database_name  = try(each.value.db_name, null)
  database_names = try(each.value.db_names, [])

  users              = try(each.value.users, null)
  admin_creds_secret = try(each.value.admin_creds_secret, null)

  init_settings = try(each.value.init_settings, null)
  settings      = try(each.value.settings, null)

  volume_type       = try(each.value.volume_type, null)
  volume_size_in_gb = try(each.value.volume_size_in_gb, null)

  backup_schedule_frequency = try(each.value.backup_schedule_frequency, null)
  backup_schedule_retention = try(each.value.backup_schedule_retention, null)
  backup_same_region        = try(each.value.backup_same_region, null)

  is_public        = try(each.value.is_public, false)
  private_networks = length(module.vpc) != 0 ? module.vpc[0].private_network_id : []
}

module "redis" {
  for_each = var.redis
  # count  = var.redis_enabled ? 1 : 0
  source = "../../modules/scw_redis"

  name          = try(each.value.name, null)
  redis_version = try(each.value.redis_version, null)
  cluster_size  = try(each.value.cluster_size, null)
  node_type     = try(each.value.node_type, null)

  creds_secret = try(each.value.creds_secret, null)

  tls_enabled = try(each.value.tls_enabled, null)
  settings    = try(each.value.settings, null)

  acls             = try(each.value.acls, null)
  private_networks = length(module.vpc) != 0 ? module.vpc[0].private_network_id : []
}

module "kubernetes_cluster" {
  count  = var.kubernetes_enabled ? 1 : 0
  source = "../../modules/kubernetes_cluster"

  name        = var.kubernetes_name
  description = var.kubernetes_description

  type        = var.kubernetes_type
  k8s_version = var.kubernetes_version
  pools       = var.kubernetes_pools

  cni = var.kubernetes_cni
  # private_network_id = var.kubernetes_private_network_id
  private_network_id = length(module.vpc) != 0 ? module.vpc[0].private_network_id[0] : null

  autoscaler_config           = var.kubernetes_autoscaler_config
  auto_upgrade                = var.kubernetes_auto_upgrade
  delete_additional_resources = var.kubernetes_delete_additional_resources

  security_group_inbound_rules = var.kubernetes_security_group_inbound_rules
}

module "sqs" {
  count = var.sqs != null ? 1 : 0

  source = "../../modules/sqs"

  queues = var.sqs.queues
  creds  = var.sqs.creds
}

module "buckets" {
  for_each = var.buckets

  source = "../../modules/scw_bucket"

  name   = each.key
  acl    = try(each.value.acl)
  region = try(each.value.region)
}

module "cockpit" {
  count = var.cockpit_enabled ? 1 : 0

  source = "../../modules/scw_cockpit"

  recipients = var.cockpit_recipients
}
