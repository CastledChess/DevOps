output "version" {
  value = var.redis_version
}

output "public_network" {
  value = scaleway_redis_cluster.this.public_network
}

output "private_network" {
  value = scaleway_redis_cluster.this.private_network
}

output "tls_enabled" {
  value = var.tls_enabled
}

output "certificate" {
  value = scaleway_redis_cluster.this.certificate
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}
