locals {
  grafana_tls_secret_name = "${replace(var.grafana_host, "/[^a-zA-Z0-9]/", "-")}-tls"
}

resource "helm_release" "prometheus" {
  name = "prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "61.9.0"

  namespace = "monitoring"

  values = [yamlencode({
    grafana = {
      defaultDashboardsTimezone = "browser"
      admin = {
        existingSecret = "grafana-credentials"
        userKey        = "username"
        passwordKey    = "password"
      }
      ingress = {
        enabled          = "true"
        ingressClassName = "nginx"
        annotations = {
          "cert-manager.io/cluster-issuer"            = "cert-manager"
          "acme.cert-manager.io/http01-edit-in-place" = "true"
        }
        hosts = [var.grafana_host]
        tls = [{
          secretName = local.grafana_tls_secret_name
          hosts      = [var.grafana_host]
        }]
      }
      persistence = {
        enabled          = "true"
        storageClassName = "scw-bssd-retain"
        accessModes      = ["ReadWriteOnce"]
      }
    }

    prometheus = {
      prometheusSpec = {
        storageSpec = {
          volumeClaimTemplate = {
            spec = {
              storageClassName = "scw-bssd-retain"
              accessModes      = ["ReadWriteOnce"]
              resources = {
                requests = {
                  storage = "50Gi"
                }
              }
            }
          }
        }
      }
    }
  })]
}

resource "helm_release" "blackbox_exporter" {
  name = "blackbox-exporter"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  version    = "9.0.0"

  namespace = "monitoring"

  values = [
    yamlencode({
      config = { modules = { https_2xx = {
        prober  = "http"
        timeout = "5s"
        http = {
          preferred_ip_protocol = "ip4"
          valid_http_versions   = ["HTTP/1.1", "HTTP/2.0"]
          method                = "GET"
          fail_if_not_ssl       = true
        } } }
      }
    })
  ]
}
