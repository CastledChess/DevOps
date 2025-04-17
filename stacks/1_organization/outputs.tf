output "developer_access_credentials" {
  value = local.developer_access_credentials
}

output "project_ids" {
  value = {
    for k, v in scaleway_account_project.projects :
    k => v.id
  }
}

output "developer_access_app_ids" {
  value = {
    for k, v in module.developer_access_iam_app :
    k => v.app_id
  }
}
