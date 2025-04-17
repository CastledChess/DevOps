output "load_balancer" {
  value = scaleway_rdb_instance.this.load_balancer
}

output "engine" {
  value = var.engine
}

output "version" {
  value = var.engine
}

output "db_names" {
  value = local.database_names
}

output "users" {
  value     = var.users
  sensitive = true
}
