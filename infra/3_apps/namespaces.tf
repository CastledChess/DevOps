resource "kubernetes_namespace" "k8s_namespaces" {
  for_each = toset(var.namespaces)

  metadata {
    name = each.key
  }
}
