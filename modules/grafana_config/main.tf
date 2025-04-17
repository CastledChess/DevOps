resource "grafana_folder" "this" {
  title = title(var.monitoring_folder)
}

data "grafana_data_source" "prometheus" {
  name = "Prometheus"
}

resource "grafana_data_source" "loki" {
  type = "loki"
  name = "loki"
  url  = "http://loki:3100"
}
