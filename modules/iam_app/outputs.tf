output "api_keys" {
  value = var.create_api_key ? {
    access_key = scaleway_iam_api_key.this[0].access_key
    secret_key = scaleway_iam_api_key.this[0].secret_key
  } : null
}

output "app_id" {
  value = scaleway_iam_application.this.id
}
