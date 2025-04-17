resource "scaleway_rdb_privilege" "admin" {
  for_each = toset(local.database_names)

  instance_id   = scaleway_rdb_instance.this.id
  user_name     = "admin_${random_password.admin_username.result}"
  database_name = each.key
  permission    = "all"

  depends_on = [scaleway_rdb_database.this]
}

resource "random_password" "admin_username" {
  length  = 12
  special = false

  # TODO remove this when fixing all the passwords
  lifecycle {
    ignore_changes = [length, lower, special, override_special]
  }
}
resource "random_password" "admin_password" {
  length           = 24
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "!#$%&*()-_=+[]{}<>:?"

  # TODO remove this when fixing all the passwords
  lifecycle {
    ignore_changes = [length, lower, special, override_special]
  }
}

module "admin_creds" {
  source = "../../modules/scw_secret"

  name = "database-credentials-${var.name}-admin"

  data = {
    (var.admin_creds_secret.host_key_name)     = length(scaleway_rdb_instance.this.private_network) > 0 ? scaleway_rdb_instance.this.private_network[0].ip : ""
    (var.admin_creds_secret.port_key_name)     = length(scaleway_rdb_instance.this.private_network) > 0 ? scaleway_rdb_instance.this.private_network[0].port : ""
    (var.admin_creds_secret.user_key_name)     = random_password.admin_username.result
    (var.admin_creds_secret.password_key_name) = random_password.admin_password.result
  }
}
