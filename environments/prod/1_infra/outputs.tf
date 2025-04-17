output "kubernetes_kubeconfig" {
  value     = module.infra.kubernetes_kubeconfig
  sensitive = true
}

output "sqs" {
  value = module.infra.sqs
}
