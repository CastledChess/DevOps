module "rule_group_status" {
  source         = "./rule_group_module"
  folder_uid     = grafana_folder.this.uid
  datasource_uid = data.grafana_data_source.prometheus.uid

  rules = [
    {
      name          = "EndpointDown"
      summary       = "Endpoint {{ $labels.instance }} is down"
      description   = "An endpoint responded with a non-2XX HTTP code"
      expression    = "probe_success != 1"
      dashboard_uid = "NEzutrbMk"
      panel_id      = "2"
    },
    {
      name          = "SSLCertificateSoonToExpire"
      summary       = "SSL Certificate for {{ $labels.instance }} expires in {{ .Value | humanizeDuration }}"
      description   = "SSL certificate is about to expire and users will encounter security issues"
      expression    = "probe_ssl_earliest_cert_expiry - time() < 86400 * 30"
      dashboard_uid = "NEzutrbMk"
      panel_id      = "2"
    },
    {
      name        = "PodKeepRestarting"
      summary     = "Pod `{{ $labels.namespace }}/{{ $labels.pod }}` has restarted {{ .Value }} times in the last 5 minutes"
      description = "Pod keeps restarting in the last 5 minutes"
      expression  = "round(increase(kube_pod_container_status_restarts_total[5m])) > 1 and on(namespace, pod) kube_pod_status_phase{phase=\"Running\"} == 1"
    }
  ]
}
