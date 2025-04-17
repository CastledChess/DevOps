resource "kubernetes_namespace" "this" {
  for_each = toset(var.k8s_namespaces)

  metadata {
    name = each.key
    labels = {
      external-secrets = true
    }
  }
}
