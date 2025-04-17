output "developer_access_credentials" {
  value     = module.organization.developer_access_credentials
  sensitive = true
}

output "project_ids" {
  value = module.organization.project_ids
}

output "developer_access_app_ids" {
  value = module.organization.developer_access_app_ids
}
