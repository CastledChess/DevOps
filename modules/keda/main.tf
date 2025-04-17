resource "helm_release" "keda" {
  repository       = "https://kedacore.github.io/charts"
  chart            = "keda"
  name             = "keda"
  namespace        = "keda"
  create_namespace = true
}
