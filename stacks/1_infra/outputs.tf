output "kubernetes_kubeconfig" {
  value = module.kubernetes_cluster[0].kubeconfig[0].config_file
}

output "sqs" {
  value = try(module.sqs[0], null)
}
