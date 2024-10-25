# Provider Azure
provider "azurerm" {
  features {}
  skip_provider_registration = true
  tenant_id                  = "901cb4ca-b862-4029-9306-e5cd0f6d9f86"
  subscription_id            = "b1063e6c-4b0d-437a-808b-acfd60aedfaf"
}

# Provider Kubernetes
provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.castled_chess_aks.kube_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.castled_chess_aks.kube_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.castled_chess_aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.castled_chess_aks.kube_config[0].cluster_ca_certificate)
}
