resource "grafana_contact_point" "contact" {
  name = "Contact"

  slack {
    url       = var.slack_webhook_url
    recipient = var.slack_channel
    text      = "{{ template \"slack.text\" . }}"
    title     = "{{ template \"slack.title\" . }}"
  }
}

resource "grafana_message_template" "slack" {
  name     = "slack"
  template = <<EOT
{{ define "alert_severity_prefix_emoji" -}}
  {{- if ne .Status "firing" -}}
    :white_check_mark:
  {{- else if eq .CommonLabels.severity "critical" -}}
    :red_circle:
  {{- else if eq .CommonLabels.severity "warning" -}}
    :warning:
  {{- end -}}
{{- end -}}

{{ define "slack.title" -}}
  {{ template "alert_severity_prefix_emoji" . }} {{- .Status | toUpper -}}{{- if eq .Status "firing" }} x {{ .Alerts.Firing | len -}}{{- end }} > {{ .CommonLabels.alertname -}}
{{- end -}}

{{- define "slack.text" -}}
{{- range .Alerts -}}
{{ if gt (len .Annotations) 0 }}
*Summary*: {{ .Annotations.summary}}
{{ if .Annotations.description }}*Description*: {{ .Annotations.description }}{{ end }}
*Labels*:
{{ range .Labels.SortedPairs }}{{ if or (eq .Name "env") (eq .Name "instance") (eq .Name "namespace") (eq .Name "pod") (eq .Name "container") }}- _{{ .Name | title }}_: `{{ .Value }}`
{{ end }}{{ end }}
{{ end }}
{{ end }}
{{ end }}
EOT
}
