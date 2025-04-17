resource "kubernetes_namespace" "security" {
  metadata {
    name = var.k8s_security_namespace
  }
}

