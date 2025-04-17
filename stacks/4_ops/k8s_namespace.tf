resource "kubernetes_namespace" "supervision" {
  metadata {
    name = var.k8s_ops_namespace
  }
}
