data "azurerm_kubernetes_cluster" "castled_chess_aks" {
  name                = "castled-chess-cluster"
  resource_group_name = "castled-chess-resource-group"
}
