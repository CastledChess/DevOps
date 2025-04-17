resource "grafana_rule_group" "status" {
  name             = "Status"
  folder_uid       = var.folder_uid
  interval_seconds = 60

  dynamic "rule" {
    for_each = var.rules
    content {
      name      = rule.value.name
      condition = "A"
      for       = "2m"

      data {
        ref_id = "A"

        relative_time_range {
          from = 600
          to   = 0
        }

        datasource_uid = var.datasource_uid
        model = jsonencode({
          editorMode    = "code"
          expr          = rule.value.expression
          instant       = true
          intervalMs    = 1000
          legendFormat  = "__auto"
          maxDataPoints = 43200
          range         = false
          refId         = "A"
        })
      }

      no_data_state  = "OK"
      exec_err_state = "Error"

      annotations = {
        summary          = rule.value.summary
        description      = rule.value.description
        __dashboardUid__ = try(rule.value.dashboard_uid, null)
        __panelId__      = try(rule.value.panel_id, null)
      }
      labels = {
        severity  = "critical"
        alertname = "EndpointDown"
      }

      notification_settings {
        contact_point = "Contact"
      }
    }
  }
}
