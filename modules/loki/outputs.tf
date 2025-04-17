output "endpoint" {
  value = "http://${helm_release.loki.name}-gateway.${helm_release.loki.namespace}.svc.cluster.local/loki/api/v1/push"
}
