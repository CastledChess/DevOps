data "scaleway_secret_version" "slack_webhook_url" {
  secret_name = "slack-webhook-url"
  revision    = "latest"
}

module "grafana" {
  source = "../../modules/grafana_config"

  monitoring_folder = var.monitoring_folder
  slack_webhook_url = base64decode(data.scaleway_secret_version.slack_webhook_url.data)
}
