resource "scaleway_redis_cluster" "this" {
  name = var.name

  version      = var.redis_version
  node_type    = var.node_type
  cluster_size = var.cluster_size

  user_name = random_password.username.result
  password  = random_password.password.result

  dynamic "acl" {
    for_each = var.acls
    content {
      ip          = acl.value["ip"]
      description = acl.value["description"]
    }
  }

  dynamic "private_network" {
    for_each = var.private_networks
    content {
      id = private_network.value
    }
  }

  tls_enabled = var.tls_enabled
  settings    = var.settings
}
