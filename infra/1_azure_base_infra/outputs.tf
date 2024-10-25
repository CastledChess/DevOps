# Output Kubernetes Config
output "kube_config" {
  description = "Fichier Kubeconfig pour se connecter à AKS"
  value       = azurerm_kubernetes_cluster.castled_chess_aks.kube_config_raw
  sensitive   = true
}
