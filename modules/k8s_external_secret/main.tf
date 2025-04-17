resource "kubernetes_manifest" "external_secret" {
  manifest = {

    apiVersion = "external-secrets.io/v1beta1"
    kind : "ExternalSecret"
    metadata = {
      name      = var.name
      namespace = var.namespace
    }
    spec = {
      refreshInterval = "10m"
      secretStoreRef = {
        name = "secret-store"
        kind = "ClusterSecretStore"
      }
      target = {
        name           = var.name
        creationPolicy = "Owner"
      }
      dataFrom = [
        {
          extract = {
            key = "id:${var.scaleway_secret_id}"
          }
        }
      ]
    }
  }
}
