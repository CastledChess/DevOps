output "id" {
  value = replace(scaleway_secret.this.id, "${scaleway_secret.this.region}/", "")
}
