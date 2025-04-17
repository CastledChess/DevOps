resource "kubernetes_namespace" "cores" {
  for_each = toset(["external-dns", "cert-manager", "external-secrets"])

  metadata {
    name = each.key

    labels = {
      name = each.key
    }

    annotations = {
      name = each.key
    }
  }
}
