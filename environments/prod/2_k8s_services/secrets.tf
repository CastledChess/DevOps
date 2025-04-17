resource "kubernetes_secret" "cloudflare_api_token" {
  for_each = toset(["external-dns", "cert-manager"])

  metadata {
    name      = local.cloudflare_api_token_secret_name
    namespace = each.value
  }

  data = {
    cloudflare_api_token = base64decode(data.scaleway_secret_version.cloudflare_api_token.data)
  }

  depends_on = [kubernetes_namespace.cores]
}
