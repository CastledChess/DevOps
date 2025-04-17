resource "helm_release" "this" {
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  name             = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true
}

resource "kubernetes_manifest" "secret_store" {
  count = var.secret_store_enabled ? 1 : 0

  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "secret-store"
    }
    spec = {
      conditions = [
        {
          namespaceSelector = {
            matchLabels = {
              "external-secrets" = "true"
            }
          }
        },
        {
          namespaces = var.allowed_namespaces
        }
      ]
      provider = {
        scaleway = {
          region    = module.provider_infos.region
          projectId = module.provider_infos.project_id
          accessKey = {
            secretRef = {
              name      = "scaleway-secret-manager-credentials"
              key       = "access_key"
              namespace = "external-secrets"
            }
          }
          secretKey = {
            secretRef = {
              name      = "scaleway-secret-manager-credentials"
              key       = "secret_key"
              namespace = "external-secrets"
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.this,
    kubernetes_secret.credentials,
  ]
}

resource "kubernetes_secret" "credentials" {
  metadata {
    name      = "scaleway-secret-manager-credentials"
    namespace = "external-secrets"
  }

  data = {
    access_key = module.iam_app.api_keys.access_key
    secret_key = module.iam_app.api_keys.secret_key
  }
}

module "iam_app" {
  source = "../iam_app"
  name   = "ExternalSecrets"
  project_name = var.scw_project_name
  
  policies = [
    {
      policy_name          = "ExternalSecrets ReadSecretsVersion"
      permission_set_names = ["SecretManagerReadOnly", "SecretManagerSecretAccess"]
    }
  ]
}

module "provider_infos" {
  source = "../scw_provider_infos"
}
