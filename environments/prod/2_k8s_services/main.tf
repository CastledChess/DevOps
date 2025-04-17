module "k8s_services" {
  source = "../../../stacks/2_k8s_services"

  scw_project_name = "Production"

  # Nginx Controller
  nginx_controller_set = {
    atomic = true
  }

  # External DNS
  external_dns_set = {
    "provider"              = "cloudflare"
    "cloudflare.secretName" = local.cloudflare_api_token_secret_name # Secret for : castled.app DNS zone
    "cloudflare.proxied"    = "true"
    # "policy"                = "sync" # default is upsert-only
  }

  # Cert Manager
  cert_manager_set = {
    cluster_issuer_email = local.certificate_email_issuer
    solvers = [
      {
        http01 = {
          ingress = {
            class = "nginx"
          }
        }
      },
      {
        dns01 = {
          cloudflare = {
            email = local.certificate_email_issuer
            apiTokenSecretRef = {
              name = local.cloudflare_api_token_secret_name
              key  = "cloudflare_api_token"
            }
          }
        }
      }
    ]
  }

  # Keda
  keda_enabled = true

  # External secrets
  external_secrets_enabled              = true
  external_secrets_secret_store_enabled = true

  # Reloader
  reloader_enabled = true

  # ArgoCD
  argocd_enabled = true
  argocd_sets = {
    # disable HTTPS as it's just a forwarded port
    "configs.params.server\\.insecure" = true

    # /!\ disable authentication, so everyone can access the instance
    "configs.params.server\\.disable\\.auth" = true
  }

  # Monitoring
  monitoring_enabled      = true
  monitoring_grafana_host = "status.castled.app"

  depends_on = [kubernetes_namespace.cores]
}
