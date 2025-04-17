resource "scaleway_cockpit" "this" {}

resource "scaleway_cockpit_alert_manager" "this" {
  enable_managed_alerts = true

  depends_on = [scaleway_cockpit.this]

  dynamic "contact_points" {
    for_each = var.recipients
    content {
      email = contact_points.value
    }
  }
}

resource "scaleway_cockpit_grafana_user" "this" {
  login = "terraform"
  role  = "editor"

  depends_on = [scaleway_cockpit.this]
}

resource "scaleway_cockpit_token" "this" {
  name = "terraform"

  scopes {
    query_logs = false
    write_logs = false

    query_metrics = false
    write_metrics = false

    query_traces = false
    write_traces = false

    setup_metrics_rules = true
    setup_alerts        = true
    setup_logs_rules    = true
  }

  depends_on = [scaleway_cockpit.this]
}

module "creds" {
  source = "../scw_secret"
  name   = "cockpit-credentials"
  data = {
    grafana_url      = scaleway_cockpit.this.endpoints[0].grafana_url
    grafana_username = scaleway_cockpit_grafana_user.this.login
    grafana_password = scaleway_cockpit_grafana_user.this.password

    cockpit_token = scaleway_cockpit_token.this.secret_key
  }
}
