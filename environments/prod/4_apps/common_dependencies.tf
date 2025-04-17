module "dependencies" {
  source = "../../../stacks/3_apps_dependencies"

  app_name = "CastledChess Prod Apps"

  # Kubernetes
  k8s_namespaces = ["castledchess"]

  # Container
  scaleway_repository_registries = {
    castledchess-prod = {
      name        = "castledchess-prod"
      description = "Registry for castledchess production apps docker images"
    }
  }

  should_create_cicd_registry_access = true

  # ArgoCD
  argocd_repository_credentials_secrets = {}
  should_create_argocd_registry_access  = false
}
