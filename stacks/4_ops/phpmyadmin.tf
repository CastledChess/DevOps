resource "helm_release" "phpmyadmin" {
  count = var.phpmyadmin_enabled ? 1 : 0

  name = "phpmyadmin"

  namespace        = var.k8s_ops_namespace
  create_namespace = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "phpmyadmin"
  version    = "17.0.6"

  depends_on = [kubernetes_namespace.supervision]
}
