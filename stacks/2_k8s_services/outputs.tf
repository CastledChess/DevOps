output "loki_endpoint" {
  value = try(module.loki[0].endpoint, null)
}
