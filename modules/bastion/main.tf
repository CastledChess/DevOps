resource "scaleway_instance_server" "this" {
  name  = "bastion"
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  ip_id = scaleway_instance_ip.this.id
  private_network {
    pn_id = var.vpc_private_network_id
  }
}

resource "scaleway_instance_ip" "this" {}
