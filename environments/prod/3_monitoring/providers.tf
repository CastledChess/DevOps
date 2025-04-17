provider "scaleway" {
  organization_id = "c41070e1-2967-4dde-8db5-dbf2f3cf63ba"
  project_id      = "e22451fc-47b2-4a90-b3a0-b180e51154c9"
}

data "scaleway_secret_version" "grafana_creds" {
  secret_name = "grafana-credentials"
  revision    = "latest"
}
locals {
  grafana_creds = jsondecode(base64decode(data.scaleway_secret_version.grafana_creds.data))
}

provider "grafana" {
  url  = "https://${local.grafana_creds.url}"
  auth = "${local.grafana_creds.username}:${local.grafana_creds.password}"
}
