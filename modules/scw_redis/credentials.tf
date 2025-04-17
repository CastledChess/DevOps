resource "random_password" "username" {
  length  = 12
  special = false
}
resource "random_password" "password" {
  length           = 24
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "creds" {
  source = "../../modules/scw_secret"

  name = "redis-credentials-${var.name}"

  data = {
    (var.creds_secret.host_key_name) = try(
      length([for pn in scaleway_redis_cluster.this.private_network : pn.service_ips[0]]) > 0 ? replace([for pn in scaleway_redis_cluster.this.private_network : pn.service_ips[0]][0], "/16", "") : "",
      ""
    )
    (var.creds_secret.user_key_name)        = random_password.username.result
    (var.creds_secret.password_key_name)    = random_password.password.result
    (var.creds_secret.certificate_key_name) = scaleway_redis_cluster.this.certificate
  }
}
