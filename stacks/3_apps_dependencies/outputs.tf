output "external_secrets" {
  value = var.external_secrets
}

output "s3_access" {
  value = try(module.s3_access[0], null)
}

output "cicd_access" {
  value = try(module.cicd_access[0], null)
}

output "registries" {
  value = [
    for _, v in scaleway_registry_namespace.this :
    v.endpoint
  ]
}
