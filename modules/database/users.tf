locals {
  # var.users = {
  #   "my_user" = {
  #     permissions = {
  #       "my_database" = "all"
  #     }
  #   }
  # }
  # ==>
  # local.users_permissions = {
  #   "my_user-my_database" = {
  #     user = "my_user"
  #     db = "my_database"
  #     perm = "all"
  #   }
  # }
  users_permissions = { for e in distinct(flatten([
    for user_name, user_object in var.users : [
      for db in keys(user_object.permissions) : {
        user = user_name
        db   = db
        perm = user_object.permissions[db]
      }
    ]
    ])) : "${e.user}-${e.db}" => e
  }
}

resource "scaleway_rdb_user" "users" {
  for_each = var.users

  instance_id = scaleway_rdb_instance.this.id
  name        = each.key
  password    = random_password.users_password[each.key].result
  is_admin    = each.value.is_admin
}

resource "scaleway_rdb_privilege" "users" {
  for_each = local.users_permissions

  instance_id   = scaleway_rdb_instance.this.id
  user_name     = each.value.user
  database_name = each.value.db
  permission    = each.value.perm

  depends_on = [scaleway_rdb_user.users, scaleway_rdb_database.this]
}

resource "random_password" "users_password" {
  for_each = var.users

  length           = 24
  override_special = "!#$%&*()-_=+[]{}<>:?"

  # TODO remove this when fixing all the passwords
  lifecycle {
    ignore_changes = [length, lower, special, override_special]
  }
}

module "users_creds" {
  source = "../../modules/scw_secret"

  for_each = var.users

  name = "database-credentials-${var.name}-${each.key}"

  data = {
    (each.value.creds_secret.host_key_name)     = length(scaleway_rdb_instance.this.private_network) > 0 ? scaleway_rdb_instance.this.private_network[0].ip : ""
    (each.value.creds_secret.port_key_name)     = length(scaleway_rdb_instance.this.private_network) > 0 ? scaleway_rdb_instance.this.private_network[0].port : ""
    (each.value.creds_secret.user_key_name)     = each.key
    (each.value.creds_secret.password_key_name) = random_password.users_password[each.key].result
  }
}
