output "bastion_ip" {
  value = scaleway_instance_server.this.public_ip
}
