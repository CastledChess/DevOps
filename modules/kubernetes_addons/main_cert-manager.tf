module "cert_manager" {
  count = var.cert_manager_enabled ? 1 : 0

  source  = "terraform-iaac/cert-manager/kubernetes"
  version = "2.6.4"

  namespace_name                         = try(var.cert_manager_set["namespace_name"], "cert-manager")
  create_namespace                       = try(var.cert_manager_set["create_namespace"], false)
  chart_version                          = try(var.cert_manager_set["chart_version"], null)
  cluster_issuer_server                  = try(var.cert_manager_set["cluster_issuer_server"], "https://acme-v02.api.letsencrypt.org/directory")
  cluster_issuer_email                   = try(var.cert_manager_set["cluster_issuer_email"], "")
  cluster_issuer_private_key_secret_name = try(var.cert_manager_set["cluster_issuer_private_key_secret_name"], "cert-manager-private-key")
  cluster_issuer_name                    = try(var.cert_manager_set["cluster_issuer_name"], "cert-manager")
  cluster_issuer_create                  = try(var.cert_manager_set["cluster_issuer_create"], true)
  cluster_issuer_yaml                    = try(var.cert_manager_set["cluster_issuer_yaml"], null)
  additional_set                         = try(var.cert_manager_set["additional_set"], [])
  solvers                                = try(var.cert_manager_set["solvers"], null)
  certificates                           = try(var.cert_manager_set["certificates"], {})
}
