module "database" {
  for_each = var.databases

  source = "../../modules/database"

  name      = each.key
  node_type = each.value.node_type
  engine    = each.value.engine

  is_ha_cluster  = each.value.is_ha_cluster
  disable_backup = each.value.disable_backup

  database_name  = each.value.db_name
  database_names = each.value.db_names

  # Remove these two lines
  # admin_username = each.value.admin_username
  # admin_password = each.value.admin_password
  users = each.value.users

  init_settings = each.value.init_settings
  settings      = each.value.settings

  volume_type       = each.value.volume_type
  volume_size_in_gb = each.value.volume_size_in_gb

  backup_schedule_frequency = each.value.backup_schedule_frequency
  backup_schedule_retention = each.value.backup_schedule_retention
  backup_same_region        = each.value.backup_same_region

  private_networks = each.value.private_networks # Ensure this is included
}

module "redis" {
  for_each = var.redis_clusters

  source = "../../modules/scw_redis"

  name          = each.key
  redis_version = each.value.version
  cluster_size  = each.value.cluster_size
  node_type     = each.value.node_type

  # Remove these two lines
  # username = each.value.username
  # password = each.value.password

  tls_enabled = each.value.tls_enabled

  acls = [{
    ip          = "0.0.0.0/0"
    description = "Allow all"
  }]
  private_networks = each.value.private_networks # Ensure this is included
}

module "sqs_queues" {
  source = "../../modules/sqs"

  sqs_queues = var.sqs_queues
  sqs_creds  = var.sqs_creds
}

module "buckets" {
  for_each = var.buckets

  source = "../../modules/scw_bucket"

  name   = each.key
  acl    = try(each.value.acl)
  region = try(each.value.region)
}

module "bucket_iam_app" {
  source = "../../modules/iam_app"

  name = "BucketAccess"
  policies = [
    {
      policy_name          = "BucketAccess"
      permission_set_names = ["ObjectStorageFullAccess"]
    }
  ]
}
