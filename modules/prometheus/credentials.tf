resource "random_password" "grafana_password" {
  length           = 24
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "grafana_credentials" {
  source = "../scw_secret"

  name = "grafana-credentials"
  data = {
    url      = var.grafana_host
    username = "admin"
    password = random_password.grafana_password.result
  }
}

module "external_secret" {
  source = "../k8s_external_secret"

  name      = "grafana-credentials"
  namespace = "monitoring"

  scaleway_secret_id = module.grafana_credentials.id
}
