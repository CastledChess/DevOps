module "external_secrets" {
  for_each = var.external_secrets

  source = "../../modules/k8s_external_secret"

  name               = each.value.name
  namespace          = each.value.namespace
  scaleway_secret_id = each.value.scaleway_secret_id
}
