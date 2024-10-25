# Ressource Group
resource "azurerm_resource_group" "castled_chess_rg" {
  name     = "${var.resource_group_name}"
  location = var.location
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "castled_chess_aks" {
  name                = "${var.cluster_name}"
  location            = azurerm_resource_group.castled_chess_rg.location
  resource_group_name = azurerm_resource_group.castled_chess_rg.name
  dns_prefix          = "${var.cluster_name}-dns"

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = "standard_b2pls_v2"
    vnet_subnet_id = azurerm_subnet.castled_chess_aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    dns_service_ip = "10.0.2.10"
    service_cidr   = "10.0.2.0/24"
  }

  tags = {
    environment = "development"
  }
}
