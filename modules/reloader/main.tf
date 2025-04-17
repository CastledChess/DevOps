resource "helm_release" "reloader" {
  repository       = "https://stakater.github.io/stakater-charts"
  chart            = "reloader"
  name             = "reloader"
  namespace        = "reloader"
  create_namespace = true
}
