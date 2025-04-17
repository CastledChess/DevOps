resource "helm_release" "dtrack" {
  count = var.dtrack_enabled ? 1 : 0

  name = "dtrack"

  namespace        = var.k8s_security_namespace
  create_namespace = true

  repository = "https://dependencytrack.github.io/helm-charts"
  chart      = "dependency-track"
  version    = "0.31.0"

  values = [
    yamlencode({
      ingress = {
        enabled = true
        annotations = {
          "acme.cert-manager.io/http01-edit-in-place"           = "true"
          "cert-manager.io/cluster-issuer"                      = "cert-manager"
          "nginx.ingress.kubernetes.io/connection-proxy-header" = "keep-alive"
        }
        hostname         = "dtrack.castled.app"
        ingressClassName = "nginx"
        tls = [
          {
            secretName = "dtrack-tls"
            hosts = [
              "dtrack.castled.app"
            ]
          }
        ]
      }
    })
  ]

  depends_on = [kubernetes_namespace.security]
}
