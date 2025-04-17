module "kubernetes_addons" {
  source = "../../modules/kubernetes_addons"

  cert_manager_enabled = var.cert_manager_enabled
  cert_manager_set     = var.cert_manager_set

  external_dns_enabled = var.external_dns_enabled
  external_dns_set     = var.external_dns_set

  nginx_controller_enabled = var.nginx_controller_enabled
  nginx_controller_set     = var.nginx_controller_set
}

module "argocd" {
  count  = var.argocd_enabled ? 1 : 0
  source = "../../modules/argocd"

  domain_name                  = var.argocd_domain_name
  exposed_to_internet          = var.argocd_exposed_to_internet
  sets                         = var.argocd_sets
  argocd_image_updater_enabled = var.argocd_image_updater_enabled
  argocd_image_updater_sets    = var.argocd_image_updater_sets
}

module "keda" {
  count  = var.keda_enabled ? 1 : 0
  source = "../../modules/keda"
}

module "external_secrets" {
  count  = var.external_secrets_enabled ? 1 : 0
  source = "../../modules/external-secrets"

  scw_project_name     = var.scw_project_name
  secret_store_enabled = var.external_secrets_secret_store_enabled
  allowed_namespaces   = var.external_secrets_allowed_namespaces
}

module "reloader" {
  count  = var.reloader_enabled ? 1 : 0
  source = "../../modules/reloader"
}


resource "kubernetes_namespace" "monitoring" {
  count = var.monitoring_enabled ? 1 : 0

  metadata {
    name = "monitoring"
    labels = {
      app              = "monitoring"
      name             = "monitoring"
      external-secrets = true
    }
  }
}

module "prometheus" {
  count  = var.monitoring_enabled ? 1 : 0
  source = "../../modules/prometheus"

  grafana_host = var.monitoring_grafana_host

  depends_on = [kubernetes_namespace.monitoring[0]]
}

module "loki" {
  count  = var.monitoring_enabled ? 1 : 0
  source = "../../modules/loki"

  depends_on = [kubernetes_namespace.monitoring[0]]
}
