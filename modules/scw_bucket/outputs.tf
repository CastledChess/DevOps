output "name" {
  value = var.name
}

output "acl" {
  value = var.acl
}

output "endpoint" {
  value = scaleway_object_bucket.this.endpoint
}

output "region" {
  value = scaleway_object_bucket.this.region
}
