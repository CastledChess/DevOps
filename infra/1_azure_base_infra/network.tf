# Virtual Network
resource "azurerm_virtual_network" "castled_chess_vnet" {
  name                = "${var.cluster_name}-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.castled_chess_rg.location
  resource_group_name = azurerm_resource_group.castled_chess_rg.name
}

# Subnet for AKS
resource "azurerm_subnet" "castled_chess_aks_subnet" {
  name                 = "${var.cluster_name}-aks-subnet"
  resource_group_name  = azurerm_resource_group.castled_chess_rg.name
  virtual_network_name = azurerm_virtual_network.castled_chess_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
