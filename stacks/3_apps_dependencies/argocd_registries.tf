locals {
  argocd_registries = merge(local._argocd_scw_registry, var.argocd_additional_registries)

  _argocd_scw_registry = var.should_create_argocd_registry_access ? {
    scaleway = {
      name        = "Scaleway"
      prefix      = "rg.fr-par.scw.cloud"
      api_url     = "https://rg.fr-par.scw.cloud"
      credentials = "secret:argocd/scaleway-registries-credentials#token"
    }
  } : {}
}

# IAM app that gives access to the registry
module "argocd_credentials" {
  count = var.should_create_argocd_registry_access ? 1 : 0

  source = "../../modules/iam_app"

  name = "ArgoCD"
  policies = [
    {
      policy_name          = "ArgoCD RegistryRO"
      permission_set_names = ["ContainerRegistryReadOnly"]
    }
  ]
  create_api_key = true
}

# Secret that holds the credentials to access to the registry
resource "kubernetes_secret" "registries_credentials" {
  count = var.should_create_argocd_registry_access ? 1 : 0

  metadata {
    name      = "scaleway-registries-credentials"
    namespace = "argocd"
  }

  data = {
    token = "nologin:${module.argocd_credentials[0].api_keys.secret_key}"
  }
}

# ConfigMap that binds the registries to their secrets
resource "kubernetes_config_map_v1_data" "registries" {
  count = length(local.argocd_registries) > 0 ? 1 : 0
  # By default, `registries.conf` == "" so we can overwrite it safely
  force = true

  metadata {
    name      = "argocd-image-updater-config"
    namespace = "argocd"
  }

  data = {
    "registries.conf" = <<EOF
registries:
  ${indent(2, yamlencode([
    # for each registry
    for _, registry in local.argocd_registries :
    {
      # select the keys with not-null values
      for k, v in registry : k => v if v != null
    }
]))}
EOF
}
}
