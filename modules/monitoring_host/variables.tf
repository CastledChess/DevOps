variable "hosts" {
  type        = list(string)
  description = "The hosts to probe"
}

variable "blackbox_exporter_endpoint" {
  type        = string
  description = "Blackbox Exporter endpoint"
  default     = "blackbox-exporter-prometheus-blackbox-exporter:9115"
}
