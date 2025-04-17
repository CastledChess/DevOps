resource "grafana_dashboard" "blackbox" {
  folder = grafana_folder.this.uid
  config_json = templatefile("${path.module}/dashboards/blackbox.json.tftpl", {
    DS_PROMETHEUS = data.grafana_data_source.prometheus.uid
  })
}

resource "grafana_dashboard" "logs" {
  folder = grafana_folder.this.uid
  config_json = templatefile("${path.module}/dashboards/logs.json.tftpl", {
    DS_LOKI = grafana_data_source.loki.uid
  })
}
