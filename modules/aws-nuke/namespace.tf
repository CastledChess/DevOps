resource "kubernetes_namespace" "aws_nuke_namespace" {
  metadata {
    name = var.namespace
  }
}
