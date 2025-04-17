locals {
  // replace dots with hyphens, and remove everything that is not a letter or hyphen
  formatted_host = replace(replace(var.hosts[0], ".", "-"), "/[^a-z-]/", "")
}

resource "kubernetes_manifest" "this" {
  manifest = yamldecode(<<EOF
apiVersion: monitoring.coreos.com/v1alpha1
kind: ScrapeConfig
metadata:
  name: ${local.formatted_host}
  namespace: monitoring
  labels:
    release: prometheus
spec:
  metricsPath: "/probe"
  params:
    module: [http_2xx]
  staticConfigs:
    - labels:
        job: ${local.formatted_host}
      targets:
        ${indent(8, yamlencode(var.hosts))}
  relabelings:
    - sourceLabels: [__address__]
      targetLabel: __param_target
    - sourceLabels: [__param_target]
      targetLabel: instance
    - targetLabel: __address__
      replacement: ${var.blackbox_exporter_endpoint}
    EOF
  )
}
